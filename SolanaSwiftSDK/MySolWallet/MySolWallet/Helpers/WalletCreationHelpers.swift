//
//  WalletCreationHelpers.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation
import SolanaPackage

public final class DummyWalletCreator: WalletCreator {
    public init(seed: [String]) throws {
        guard !seed.isEmpty else {
            throw CreatorError.emptySeed
        }
        self.seed = seed
    }
    
    enum CreatorError: Swift.Error {
        case emptySeed
    }
    
    private let seed: [String]
    
    public func create() throws -> (String, String)? {
        try self.createWallet()
    }
    
    private func createWallet() throws -> (String,String)? {
        // make the conversion AKA wallet creation via accessing 3rd party
        return (self.seed[0], self.seed[1])
    }
}
