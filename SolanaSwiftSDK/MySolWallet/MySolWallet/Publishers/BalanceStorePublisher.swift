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

public final class BalanceStorePublisher {
    
    private init() {}
    public typealias BalanceViewModelPublisher = ViewModelPublisher<Balance, PresentableBalance>
    private static var cancellable: AnyCancellable?
    
    public static func bindToBalancePublisher(_ balancePublisher: AnyPublisher<Balance, Error>) -> BalanceViewModelPublisher {
        var balanceViewModelPublisher = BalanceViewModelPublisher(resource: Balance(amount: 0), mapper: BalanceStoreMapper.map)
        
        BalanceStorePublisher.cancellable = balancePublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { balance in
                balanceViewModelPublisher = BalanceViewModelPublisher(resource: balance, mapper: BalanceStoreMapper.map)
            })
        
        return balanceViewModelPublisher
    }
}
