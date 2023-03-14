//
//  TransactionStoreMapper.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

public class TransactionStoreMapper {
        
    public static func map(_ domainTransactions: [DomainTransaction]) -> [TransactionUI] {
        guard !domainTransactions.isEmpty else { return [] }
        return domainTransactions.map { TransactionUI(date: $0.date,
                                                      from: $0.from,
                                                      to: $0.to,
                                                      amount: $0.amount,
                                                      currencyName: $0.amount,
                                                      transactionSignature: $0.transactionSignature)
            
        }
    }
}

