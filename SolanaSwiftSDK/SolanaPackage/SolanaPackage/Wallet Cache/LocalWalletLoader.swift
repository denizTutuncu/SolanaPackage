//
//  LocalWalletLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public final class LocalWalletLoader {
    private let store: WalletStore
    private let currentDate: () -> Date
    
    public init(store: WalletStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalWalletLoader: WalletCache {
    public func save(_ wallet: [Wallet], privateKey: String) throws {
        try store.deleteCachedWallet()
        try store.insert(wallet.toLocal(privateKey: privateKey), timestamp: currentDate())
    }
}

extension LocalWalletLoader {
    public func load() throws -> [Wallet] {
        if let cache = try store.retrieve(), WalletCachePolicy.validate(cache.timestamp, against: currentDate()) {
            return cache.wallet.toModels()
        }
        return []
    }
}

extension LocalWalletLoader {
    private struct InvalidCache: Error {}
    
    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(), !WalletCachePolicy.validate(cache.timestamp, against: currentDate()) {
                throw InvalidCache()
            }
        } catch {
            try store.deleteCachedWallet()
        }
    }
}

private extension Array where Element == Wallet {
    func toLocal(privateKey: String) -> [LocalWallet] {
        return map { LocalWallet(id: $0.id, publicKey: $0.publicKey, privateKey: privateKey, balance: $0.balance) }
    }
}

private extension Array where Element == LocalWallet {
    func toModels() -> [Wallet] {
        return map { Wallet(id: $0.id, publicKey: $0.publicKey, balance: $0.balance) }
    }
}
