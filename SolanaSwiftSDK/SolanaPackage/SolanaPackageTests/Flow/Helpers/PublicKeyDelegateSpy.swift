//
//  WalletDelegateSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
import SolanaPackage

class PublicKeyDelegateSpy: PublicKeyDelegate {
    var publicKeyCompletions: [([String]) -> Void] = []
    var passedPublicKeys: [String] = []
    
    func didComplete(completion: @escaping ([String]) -> Void) {
        publicKeyCompletions.append(completion)
    }
    
}

class SeedDelegateSpy: SeedDelegate {
    typealias Seed = String
    var seed: [Seed] = []
    
    func didComplete(completion: [Seed]) {
        seed = completion
    }
        
}

