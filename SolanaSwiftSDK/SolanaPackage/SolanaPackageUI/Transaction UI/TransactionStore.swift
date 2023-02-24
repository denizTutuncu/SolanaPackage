//
//  TransactionStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
struct TransactionStore {
    var txs: [Transaction]
    
    private let handler: ([String]) -> Void
    
    init(txs: [Transaction], handler: @escaping ([String]) -> Void) {
        self.txs = txs.map { Transaction(date: $0.date, from: $0.from, to: $0.to, amount: $0.amount, currencyName: $0.currencyName, transactionSignature: $0.transactionSignature) }
        self.handler = handler
    }
    
    func submit() {
        handler(txs.map{$0.transactionSignature})
    }
}

struct Transaction {
    let date: String
    let from: String
    let to: String
    let amount: String
    let currencyName: String
    let transactionSignature: String
}
