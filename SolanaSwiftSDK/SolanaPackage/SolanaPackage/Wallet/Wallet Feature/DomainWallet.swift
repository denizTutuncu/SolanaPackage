//
//  Wallet.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/17/23.
//

import Foundation

public struct DomainWallet: Hashable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
