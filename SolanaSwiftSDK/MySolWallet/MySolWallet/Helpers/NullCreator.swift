//
//  NullCreator.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation
import SolanaPackage

class NullCreator {}

extension NullCreator: WalletCreator {
    func create() throws -> (String, String)? { return .none }
}

