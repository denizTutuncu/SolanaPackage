//
//  LocalPublicKeyLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation

public final class LocalPublicKeyLoader {
    public typealias PublicKey = String
    
    public init(store: PublicKeyStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }

    private let store: PublicKeyStore
    private let currentDate: () -> Date
}

extension LocalPublicKeyLoader: PublicKeyCache {
    public func save(_ publicKeys: [PublicKey]) throws {
        if !PublicKeyCachePolicy.isEmpty(publicKeys) {
            let validKeys = PublicKeyCachePolicy.getValidPublicKeys(from: publicKeys)
            
            if !PublicKeyCachePolicy.isEmpty(validKeys) {
                try store.insert(validKeys, timestamp: currentDate())
            }
        }
    }
}

extension LocalPublicKeyLoader {
    public func load() throws -> [PublicKey] {
        if let cache = try store.retrieve() {
            return cache.publicKeys
        }
        return []
    }
}

extension LocalPublicKeyLoader {
    public func delete(_ publicKeys: [PublicKey]) throws {
        try store.deleteCached(publicKeys)
    }
}

extension LocalPublicKeyLoader {
    
    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(),
               !PublicKeyCachePolicy.isEmpty(cache.publicKeys) {
                let invalidPubKeys = PublicKeyCachePolicy.getInvalidPublicKeys(from: cache.publicKeys)
                
                if !PublicKeyCachePolicy.isEmpty(invalidPubKeys) {
                    try store.deleteCached(invalidPubKeys)
                }
            }
        } catch let error {
            throw error
        }
    }
}
