//
//  LocalWalletLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/20/25.
//

import Foundation

extension LocalWalletLoader: WalletCreator {
    public func create() async throws -> (WalletCreator.PublicKey, WalletCreator.PrivateKey)? {
        try await creator.create()
    }
}

public final class LocalWalletLoader {
    public init(creator: WalletCreator) {
        self.creator = creator
    }
    private let creator: WalletCreator
}
