//
//  LocalWallet.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public struct LocalWallet: Equatable, Encodable {
    public let id: UUID
    public let publicKey: String
    public let privateKey: String
    public let balance: Double

    
    public init(id: UUID, publicKey: String, privateKey: String, balance: Double) {
        self.id = id
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.balance = balance
    }
}
