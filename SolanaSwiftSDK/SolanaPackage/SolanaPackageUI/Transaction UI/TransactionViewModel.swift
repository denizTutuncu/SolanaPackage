//
//  TransactionStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public struct TransactionViewModel {
    public var transactions: [PresentableTransaction]
        
    public init(transactions: [PresentableTransaction]) {
        self.transactions = transactions
    }
    
    public var onLoadingState: Bool {
        self.transactions.isEmpty
    }
}
