//
//  Wallet.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/17/23.
//

import Foundation

public struct Wallet: Hashable {
    public let id: UUID
    public let publicKey: String
    public let balance: Double
    
    public init(id: UUID, publicKey: String, balance: Double) {
        self.id = id
        self.publicKey = publicKey
        self.balance = balance
    }
}
