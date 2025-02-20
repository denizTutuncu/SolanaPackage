//
//  TransactionStorePublisher.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/19/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class TransactionStorePublisher {
    
    private init() {}
    public typealias TransactionViewModelPublisher = ViewModelPublisher<[DomainTransaction], [PresentableTransaction]>
    private static var cancellable: AnyCancellable?

    public static func bindToTransactionPublisher(_ transactionPublisher: AnyPublisher<[DomainTransaction], Error>) -> TransactionViewModelPublisher {
        var transactionViewModelPublisher = TransactionViewModelPublisher(resource: [], mapper: TransactionStoreMapper.map)
        
        TransactionStorePublisher.cancellable = transactionPublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { completion in
                transactionViewModelPublisher = TransactionViewModelPublisher(resource: [], mapper: TransactionStoreMapper.map)
            },
                  receiveValue: { transactions in
                transactionViewModelPublisher = TransactionViewModelPublisher(resource: transactions, mapper: TransactionStoreMapper.map)
            })
        
        return transactionViewModelPublisher
    }
}

