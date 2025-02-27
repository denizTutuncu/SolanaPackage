//
//  SolanaWalletCreator.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation
import SolanaPackage
import SolanaSwift

public final class SolanaWalletCreator: WalletCreator {
    public init(seed: [String]) throws {
        self.seed = seed
    }
 
    private let seed: [String]
    
    public func create() async throws -> (String, Data)? {
        try await self.createWallet()
    }
    
    private func createWallet() async throws -> (String,Data)? {
        let keyPair = try await KeyPair(phrase: seed, network: .devnet)
        return (keyPair.publicKey.base58EncodedString, keyPair.secretKey)
    }
}
