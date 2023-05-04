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
        
    public static func map(_ domainTransactions: [DomainTransaction]) -> [PresentableTransaction] {
        guard !domainTransactions.isEmpty else { return [] }
        return domainTransactions.map { PresentableTransaction(date: $0.date,
                                                      from: $0.from,
                                                      to: $0.to,
                                                      amount: $0.amount,
                                                      currencyName: $0.amount,
                                                      signature: $0.signature)
            
        }
    }
}

