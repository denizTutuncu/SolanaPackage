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
        return domainTransactions.map { txn in
            PresentableTransaction(
                date: txn.date,
                from: txn.from,
                to: txn.to,
                amount: txn.amount,
                currencyName: txn.currencyName,
                signature: txn.signature
            )
        }
    }
}
