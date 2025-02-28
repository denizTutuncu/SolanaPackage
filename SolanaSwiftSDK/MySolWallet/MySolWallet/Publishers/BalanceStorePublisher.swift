//
//  BalanceStorePublisher.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/12/24.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class BalanceStorePublisher: ObservableObject {
    public typealias BalanceViewModelPublisher = ViewModelPublisher<PresentableBalance, PresentableBalance>

    @Published public private(set) var balanceViewModelPublisher = BalanceViewModelPublisher(mapper: { $0 })

    private var cancellable: AnyCancellable?

    public func bind(to publisher: AnyPublisher<PresentableBalance, Error>) {
        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] balance in
                self?.balanceViewModelPublisher = BalanceViewModelPublisher(mapper: { $0 })
                self?.balanceViewModelPublisher.bind(
                    to: Just(balance)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                )
            })
    }
}
