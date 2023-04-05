//
//  WalletDelegateSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
import SolanaPackage

class WalletDelegateSpy: PublicKeyDelegate {
    var walletCompletions: [([String]) -> Void] = []
    var passedWallets: [String] = []
    
    func didComplete(completion: @escaping ([String]) -> Void) {
        walletCompletions.append(completion)
    }
    
}

class SeedDelegateSpy: SeedDelegate {
    typealias Seed = String
    var seed: [Seed] = []
    
    func didComplete(completion: [Seed]) {
        seed = completion
    }
        
}

