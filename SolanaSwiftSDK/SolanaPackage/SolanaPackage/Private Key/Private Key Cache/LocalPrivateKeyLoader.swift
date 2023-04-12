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
    public typealias PrivateKey = String
    
    private let store: PrivateKeyStore
}

extension LocalPrivateKeyLoader: WalletCache {
    public func save(_ wallet: DomainWallet, privateKey: PrivateKey) throws {
        try store.insert(publicKey: wallet.id, privateKey: privateKey)
    }
}

extension LocalPrivateKeyLoader {
    private struct InvalidPublicKey: Error {}
    
    public func privateKey(for publicKey: PublicKey) throws -> PrivateKey? {
        guard PrivateKeyCachePolicy.validate(publicKey: publicKey) else {
            throw InvalidPublicKey()
        }
        
        let cache = try store.privateKey(for: publicKey)
        
        if PrivateKeyCachePolicy.validate(privateKey: cache) {
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
        try store.deletePrivateKey(for: publicKey)
    }
}
