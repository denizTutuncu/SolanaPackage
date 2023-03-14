//
//  TransactionStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public struct TransactionStore {
    public var transactions: [TransactionUI]
        
    public init(transactions: [TransactionUI]?) {
        self.transactions = transactions ?? []
    }
}

public struct TransactionUI {
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
