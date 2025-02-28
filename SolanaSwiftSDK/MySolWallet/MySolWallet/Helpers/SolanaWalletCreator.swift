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
    public init(seed: [String]) {
        self.seed = seed
    }
 
    private let seed: [String]
    
    public func create() async throws -> (WalletCreator.PublicKey, WalletCreator.PrivateKey)? {
        try await self.createWallet()
    }
    
    private func createWallet() async throws -> (String, Data)? {
        guard !seed.isEmpty else { throw NSError(domain: "Invalid seed phrase", code: 0, userInfo: nil)}
        let keyPair = try await KeyPair(phrase: seed, network: .devnet)
        return (keyPair.publicKey.base58EncodedString, keyPair.secretKey)
    }
}
