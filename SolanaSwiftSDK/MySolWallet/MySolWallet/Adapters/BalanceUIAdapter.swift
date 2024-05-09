//
//  BalanceUIAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/12/24.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class BalanceUIAdapter {
    
    private init() {}
    public typealias BalanceStorePublisher = ViewModelPublisher<[Double], [Balance]>
    private static var cancellable: AnyCancellable?
    
    public static func balanceComposedWith(balancePublisher: AnyPublisher<[Double], Error>) -> BalanceStorePublisher {
        var balanceStorePublisher = BalanceStorePublisher(resource: [], mapper: BalanceStoreMapper.map)
        
        BalanceUIAdapter.cancellable = balancePublisher
            .dispatchOnMainQueue()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { balance in
                balanceStorePublisher = BalanceStorePublisher(resource: balance, mapper: BalanceStoreMapper.map)
            })
        
        return balanceStorePublisher
    }
}

