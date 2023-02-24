//
//  FlowDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol WalletDelegate {
    associatedtype Wallet
    func navigate(from: Wallet, completion: @escaping (Wallet) -> Void)
}
