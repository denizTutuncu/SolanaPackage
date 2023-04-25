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
    public typealias TransactionStorePublisher = ViewModelPublisher<[DomainTransaction], [PresentableTransaction]>
    private static var cancellable: AnyCancellable?
    
    private init() {}
    
    deinit {
        TransactionUIAdapter.cancellable?.cancel()
    }
    
    public static func publicKeyComposedWith(transactionPublisher: AnyPublisher<[DomainTransaction], Error>) -> TransactionStorePublisher {
        var transactionStorePublisher = TransactionStorePublisher(resource: [], mapper: TransactionStoreMapper.map)
        
        TransactionUIAdapter.cancellable = transactionPublisher
            .sink(receiveCompletion: { completion in
                transactionStorePublisher = TransactionStorePublisher(resource: [], mapper: TransactionStoreMapper.map)
            },
                  receiveValue: { transactions in
                transactionStorePublisher = TransactionStorePublisher(resource: transactions, mapper: TransactionStoreMapper.map)
            })
        
        return transactionStorePublisher
    }
}

