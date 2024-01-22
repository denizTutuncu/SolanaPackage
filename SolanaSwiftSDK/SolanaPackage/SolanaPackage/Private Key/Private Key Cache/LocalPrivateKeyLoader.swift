//
//  LocalWalletLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public final class LocalPrivateKeyLoader {
    public init(store: PrivateKeyStore) {
        self.store = store
    }
    
    public typealias PublicKey = String
    public typealias PrivateKey = Data
    
    private let store: PrivateKeyStore
}

extension LocalPrivateKeyLoader: PrivateKeyCache {
    private struct InvalidPrivateKey: Error{}
    private struct InvalidPublicKey: Error{}
    
    public func save(_ publicKey: PublicKey, privateKey: PrivateKey) throws {
        
        guard PrivateKeyCachePolicy.validate(publicKey: publicKey) else {
            throw InvalidPublicKey()
        }
        
        guard PrivateKeyCachePolicy.validate(privateKey: privateKey) else {
            throw InvalidPrivateKey()
        }
        
        try store.store(publicKey: publicKey, privateKey: privateKey)
    }
}

extension LocalPrivateKeyLoader {
    public func privateKey(for publicKey: PublicKey) throws -> PrivateKey? {
        guard PrivateKeyCachePolicy.validate(publicKey: publicKey) else {
            throw InvalidPublicKey()
        }
        
        if let cache = try store.read(for: publicKey),  PrivateKeyCachePolicy.validate(privateKey: cache) {
            return cache
        }
        
        return nil
    }
}

extension LocalPrivateKeyLoader {
    public func deletePrivateKey(for publicKey: PublicKey?) throws {
        guard let publicKey = publicKey else {
            return
        }
        try store.deleteKey(for: publicKey)
    }
}
