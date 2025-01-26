//
//  SendSOLModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import Foundation

public struct SendSOLModel {
    public init(recipientPublicKey: String, amount: String) {
        self.recipientPublicKey = recipientPublicKey
        self.amount = amount
    }
    public let recipientPublicKey: String
    public let amount: String
}
