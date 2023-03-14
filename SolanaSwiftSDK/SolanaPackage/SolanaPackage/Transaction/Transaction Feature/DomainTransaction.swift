//
//  DomainTransaction.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct DomainTransaction {
    public let date: String
    public let from: String
    public let to: String
    public let amount: String
    public let currencyName: String
    public let transactionSignature: String
    
    public init(date: String, from: String, to: String, amount: String, currencyName: String, transactionSignature: String) {
        self.date = date
        self.from = from
        self.to = to
        self.amount = amount
        self.currencyName = currencyName
        self.transactionSignature = transactionSignature
    }
}
