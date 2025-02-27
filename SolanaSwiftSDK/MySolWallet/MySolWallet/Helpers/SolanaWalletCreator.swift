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
    
    private func createWallet() async throws -> (String, Data)? {
        print("Provided seed phrase to the creator is \(seed)")

        // ✅ Normalize the seed phrase
        let normalizedSeed = seed.map { $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) }
        print("Normalized seed phrase to the creator is \(normalizedSeed)")
        
        let keyPair = try await KeyPair(phrase: normalizedSeed, network: .devnet)
        return (keyPair.publicKey.base58EncodedString, keyPair.secretKey)
    }

}
