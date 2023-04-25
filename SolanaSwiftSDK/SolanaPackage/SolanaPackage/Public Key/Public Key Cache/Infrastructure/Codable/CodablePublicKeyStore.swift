//
//  CodablePublicKeyStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/19/23.
//

import Foundation

public final class CodablePublicKeyStore: PublicKeyStore {
    
    public init(storeURL: URL) throws {
        guard !storeURL.absoluteString.isEmpty else {
            throw StoreError.emptyStoreURL
        }
        self.storeURL = storeURL
    }
    
    enum StoreError: Error {
        case emptyStoreURL
    }
    
    private let storeURL: URL
    private let queue = DispatchQueue(label: "\(CodablePublicKeyStore.self)Queue", qos: .userInitiated, attributes: .concurrent)
    
    private struct Cache: Codable {
        let publicKeys: [CodablePublicKey]
        let timestamp: Date
        
        var localPublicKeys: [LocalPublicKey] {
            return publicKeys.map { $0.local }
        }
    }
    
    private struct CodablePublicKey: Codable {
        let id: String
        
        init(_ publicKey: LocalPublicKey) {
            id = publicKey.id
        }
        
        var local: LocalPublicKey {
            return LocalPublicKey(id: id)
        }
    }
    
    public func retrieve() throws -> CachedPublicKey? {
        let storeURL = self.storeURL
        var cachedPublicKey: CachedPublicKey?
        var cachedData: Data?
        queue.sync {
            do {
                cachedData = try Data(contentsOf: storeURL)
            } catch {
                cachedPublicKey = nil
            }
        }
        if let cachedData = cachedData {
            let decoder = JSONDecoder()
            do {
                let cache = try decoder.decode(Cache.self, from: cachedData)
                cachedPublicKey = (publicKeys: cache.publicKeys.map { $0.id }, timestamp: cache.timestamp)
            } catch {
                throw error
            }
        }
        return cachedPublicKey
    }
    
    public func insert(_ publicKeys: [String], timestamp: Date) throws {
        guard !publicKeys.isEmpty else { return }
        let storeURL = self.storeURL
        let encoder = JSONEncoder()
        let cache = Cache(publicKeys: publicKeys.map { CodablePublicKey(LocalPublicKey(id: $0)) }, timestamp: timestamp)
        let encoded = try encoder.encode(cache)
        try queue.sync(flags: .barrier) {
            do {
                try encoded.write(to: storeURL)
            } catch {
                throw error
            }
        }
    }
    
    public func deleteCached(_ publicKeys: [String]) throws {
        guard !publicKeys.isEmpty else { return }
        let storeURL = self.storeURL
        
        guard FileManager.default.fileExists(atPath: storeURL.path) else {
            return
        }
        
        try queue.sync(flags: .barrier) {
            do {
                try FileManager.default.removeItem(at: storeURL)
            } catch {
                throw error
            }
        }
    }
    
}

public struct LocalPublicKey: Equatable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
