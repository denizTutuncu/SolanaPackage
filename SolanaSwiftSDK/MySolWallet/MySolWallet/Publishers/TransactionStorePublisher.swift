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

public final class TransactionStorePublisher: ObservableObject {
    public typealias TransactionViewModelPublisher = ViewModelPublisher<[PresentableTransaction], [PresentableTransaction]> // ✅ Corrected type
    
    @Published public private(set) var transactionViewModelPublisher = TransactionViewModelPublisher(mapper: { $0 }) // ✅ Direct mapping
    
    private var cancellable: AnyCancellable?
    
    public func bind(to publisher: AnyPublisher<[PresentableTransaction], Error>) { // ✅ Updated expected type
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] transactions in
                self?.transactionViewModelPublisher = TransactionViewModelPublisher(mapper: { $0 })
                self?.transactionViewModelPublisher.bind(
                    to: Just(transactions)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
            })
    }
}
