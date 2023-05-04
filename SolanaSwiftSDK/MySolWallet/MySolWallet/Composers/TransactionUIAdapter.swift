//
//  TransactionUIAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/19/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class TransactionUIAdapter {
    
    private init() {}
    public typealias TransactionStorePublisher = ViewModelPublisher<[DomainTransaction], [PresentableTransaction]>
    private static var cancellable: AnyCancellable?

    public static func publicKeyComposedWith(transactionPublisher: AnyPublisher<[DomainTransaction], Error>) -> TransactionStorePublisher {
        var transactionStorePublisher = TransactionStorePublisher(resource: [], mapper: TransactionStoreMapper.map)
        
        TransactionUIAdapter.cancellable = transactionPublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { completion in
                transactionStorePublisher = TransactionStorePublisher(resource: [], mapper: TransactionStoreMapper.map)
            },
                  receiveValue: { transactions in
                transactionStorePublisher = TransactionStorePublisher(resource: transactions, mapper: TransactionStoreMapper.map)
            })
        
        return transactionStorePublisher
    }
}

