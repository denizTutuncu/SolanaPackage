//
//  WalletStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/4/23.
//

import Foundation

public typealias CacheWallet = (wallet: [String], timestamp: Date)

public protocol WalletStore {
    func deleteCachedWallet() throws
    func insert(_ wallets: [String], timestamp: Date) throws
    func retrieve() throws -> CacheWallet?
}
