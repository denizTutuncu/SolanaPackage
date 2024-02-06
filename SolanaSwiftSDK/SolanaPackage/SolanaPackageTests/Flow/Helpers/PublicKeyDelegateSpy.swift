//
//  WalletDelegateSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
import SolanaPackage

class PublicKeyDelegateSpy: PublicKeyDelegate {
    var passedPublicKeys: [String] = []

    func didCompleteWith(keys: [String]) {
        passedPublicKeys = keys
    }
}
