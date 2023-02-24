//
//  WalletDelegateSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
import SolanaPackage

class WalletDelegateSpy: WalletDelegate {
    typealias Wallet = String
    
    var passedWallets: [Wallet] = []
    var walletCompletions: [(Wallet) -> Void] = []
    var completedWallets: [[(Wallet, Wallet)]] = []
    
    func navigateToWalletCreation() {}
    
    func navigate(from: Wallet, completion: @escaping (Wallet) -> Void) {
        passedWallets.append(from)
        walletCompletions.append(completion)
        completedWallets.append([(from, from)])
    }
}
