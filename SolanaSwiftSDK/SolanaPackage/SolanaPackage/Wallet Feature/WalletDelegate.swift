//
//  FlowDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol WalletDelegate {
    associatedtype Wallet: WalletProtocol
    func navigateToWalletCreation()
    func navigateToWallet(from wallets: [Wallet])
}
