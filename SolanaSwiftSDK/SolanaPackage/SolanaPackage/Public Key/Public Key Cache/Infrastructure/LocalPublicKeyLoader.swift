//
//  LocalPublicKeyLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation

public final class LocalPublicKeyLoader {
    private let store: PublicKeyStore
    private let currentDate: () -> Date
    
    public init(store: PublicKeyStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalPublicKeyLoader: PublicKeyCache {
    public func save(_ publicKeys: [String]) throws {
        try store.deleteCached(publicKeys)
        try store.insert(publicKeys, timestamp: currentDate())
    }
}

extension LocalPublicKeyLoader {
    public func load() throws -> [String] {
        if let cache = try store.retrieve() {
            return cache.publicKeys
        }
        return []
    }
}

extension LocalPublicKeyLoader {
    public func delete(_ publicKeys: [String]) throws {
        try store.deleteCached(publicKeys)
    }
}
