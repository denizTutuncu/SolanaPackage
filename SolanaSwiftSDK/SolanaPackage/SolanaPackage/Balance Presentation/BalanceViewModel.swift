//
//  BalanceViewModel.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import Foundation

public class BalanceViewModel {
    public let amount: Double
    public init(amount: Double = 0.0) {
        self.amount = amount
    }
}

extension BalanceViewModel: Equatable {
    public static func == (lhs: BalanceViewModel, rhs: BalanceViewModel) -> Bool {
        lhs.amount == rhs.amount
    }
}
