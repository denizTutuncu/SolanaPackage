//
//  SeedLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public protocol SeedLoaderProtocol {
    associatedtype Wallet: WalletProtocol
    func load(completion: @escaping (Wallet) -> Void)
}
