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
    typealias Seed = [String]

    var passedWallets: [Wallet] = []
    var walletCompletions: [([Wallet]) -> Void] = []
    var completedWallets: [[(Wallet, Wallet)]] = []
    var seed: Seed = []
        
    func didComplete(with: [Wallet]) {
        for w in with {
            passedWallets.append(w)
            completedWallets.append([(w, w)])
        }
    }
    
    func didComplete(with: Seed, completion: @escaping ([Wallet]) -> Void) {
        for inComingSeed in with {
            seed.append(inComingSeed)
        }
        walletCompletions.append(completion)
      
    }
    
}
