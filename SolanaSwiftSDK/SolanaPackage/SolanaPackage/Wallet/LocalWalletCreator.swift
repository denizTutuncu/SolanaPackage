//
//  LocalWalletCreator.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/20/25.
//

import Foundation

extension LocalWalletCreator: WalletCreator {
    public func create() async throws -> (WalletCreator.PublicKey, WalletCreator.PrivateKey)? {
        try await creator.create()
    }
}

public final class LocalWalletCreator {
    public init(creator: WalletCreator) {
        self.creator = creator
    }
    private let creator: WalletCreator
}
