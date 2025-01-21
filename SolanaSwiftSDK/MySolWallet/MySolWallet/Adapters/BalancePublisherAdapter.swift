//
//  BalancePublisherAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/12/24.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class BalancePublisherAdapter {
    
    private init() {}
    public typealias BalanceStorePublisher = ViewModelPublisher<Balance, PresentableBalance>
    private static var cancellable: AnyCancellable?
    
    public static func balanceComposedWith(balancePublisher: AnyPublisher<Balance, Error>) -> BalanceStorePublisher {
        var balanceStorePublisher = BalanceStorePublisher(resource: Balance(amount: 0), mapper: BalanceStoreMapper.map)
        
        BalancePublisherAdapter.cancellable = balancePublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { balance in
                balanceStorePublisher = BalanceStorePublisher(resource: balance, mapper: BalanceStoreMapper.map)
            })
        
        return balanceStorePublisher
    }
}

