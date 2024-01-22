//
//  WalletCreation.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation

public protocol WalletCreator {
    func create() async throws -> (String,String)?
}

public protocol WalletCreationLoader {
    func load() async throws -> (String,String)?
}

extension LocalWalletCreationLoader: WalletCreationLoader {
    public func load() async throws -> (String, String)? {
        try await creator.create()
    }
}

public final class LocalWalletCreationLoader {
    public init(creator: WalletCreator) {
        self.creator = creator
    }
    private let creator: WalletCreator
}
