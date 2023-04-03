//
//  LocalWalletLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public final class LocalCredentialsLoader {
    public init(store: CredentialsStore) {
        self.store = store
    }
    
    public typealias PublicKey = String
    public typealias PrivateKey = String
    
    private let store: CredentialsStore
}

extension LocalCredentialsLoader: WalletCache {
    public func save(_ wallet: DomainWallet, privateKey: PrivateKey) throws {
        try store.insert(publicKey: wallet.id, privateKey: privateKey)
    }
}

extension LocalCredentialsLoader {
    private struct InvalidPublicKey: Error {}
    
    public func privateKey(for publicKey: PublicKey) throws -> PrivateKey {
        guard KeychainWalletCachePolicy.validate(publicKey: publicKey) else {
            throw InvalidPublicKey()
        }
        
        let cache = try store.privateKey(for: publicKey)
        if KeychainWalletCachePolicy.validate(privateKey: cache) {
            return cache
        }
        return ""
    }
}

extension LocalCredentialsLoader {
    public func deletePrivateKey(for publicKey: PublicKey?) throws {
        guard let publicKey = publicKey else {
            return
        }
        try store.deletePrivateKey(for: publicKey)
    }
}
