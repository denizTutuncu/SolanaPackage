//
//  DomainTransaction.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct DomainTransaction: Hashable {
    public init(date: String, from: String, to: String, amount: String, currencyName: String, signature: String) {
        self.date = date
        self.from = from
        self.to = to
        self.amount = amount
        self.currencyName = currencyName
        self.signature = signature
    }
    public let date: String
    public let from: String
    public let to: String
    public let amount: String
    public let currencyName: String
    public let signature: String
}
