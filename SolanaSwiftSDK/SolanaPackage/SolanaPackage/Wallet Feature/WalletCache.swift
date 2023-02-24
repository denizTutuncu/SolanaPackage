//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public protocol WalletCache {
    func save(_ wallet: [DomainWallet], privateKey: String) throws
}
