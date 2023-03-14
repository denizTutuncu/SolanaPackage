//
//  FlowDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol WalletDelegate {
    associatedtype Seed
    associatedtype Wallet
    func didComplete(with: [Wallet])
    func didComplete(with: Seed, completion: @escaping ([Wallet]) -> Void)
}
