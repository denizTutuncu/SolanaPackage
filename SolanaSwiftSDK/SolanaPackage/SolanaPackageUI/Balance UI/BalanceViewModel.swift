//
//  BalanceViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/17/23.
//

import Foundation

public struct BalanceViewModel {
    
    public init(balance: PresentableBalance) {
        self.balance = balance
    }
    
    public var onLoadingState: Bool {
        self.balance.value.isEmpty
    }
    
    public let balance: PresentableBalance
}
