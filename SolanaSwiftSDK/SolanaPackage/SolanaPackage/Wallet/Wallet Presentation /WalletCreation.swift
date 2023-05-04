//
//  WalletCreation.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation

public protocol WalletCreator {
    func create() throws -> (String,String)?
}

public protocol WalletCreationLoader {
    func load() throws -> (String,String)?
}

extension LocalWalletCreationLoader: WalletCreationLoader {
    public func load() throws -> (String, String)? {
        try creator.create()
    }
}

public final class LocalWalletCreationLoader {
    public init(creator: WalletCreator) {
        self.creator = creator
    }
    private let creator: WalletCreator
}
