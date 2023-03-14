//
//  Wallet.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/17/23.
//

import Foundation

public struct DomainWallet: Hashable {
    public let id: UUID
    public let publicKey: String

    public init(id: UUID = UUID(), publicKey: String) {
        self.id = id
        self.publicKey = publicKey
    }
}
