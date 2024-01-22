//
//  WalletCreationHelpers.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation
import SolanaPackage
import SolanaSwift

public final class MainWalletCreator: WalletCreator {
    public init(seed: [String], loader: SeedPhraseLoader) throws {
        guard !seed.isEmpty else {
            throw CreatorError.emptySeed
        }
        self.seed = seed
        self.loader = loader
    }
    
    enum CreatorError: Swift.Error {
        case emptySeed
    }
    
    private let seed: [String]
    private let loader: SeedPhraseLoader
    
    public func create() async throws -> (String, String)? {
        try await self.createWallet()
    }
    
    private func createWallet() async throws -> (String,String)? {
        let keyPair = try await KeyPair(phrase: try loader.load(), network: .mainnetBeta)
        return (keyPair.publicKey.base58EncodedString, keyPair.secretKey.base64EncodedString())
    }
}
