//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public typealias CachedWallet = (wallet: [LocalWallet], timestamp: Date)

public protocol WalletStore {
    func deleteCachedWallet() throws
    func insert(_ wallet: [LocalWallet], timestamp: Date) throws
    func retrieve() throws -> CachedWallet?
}
