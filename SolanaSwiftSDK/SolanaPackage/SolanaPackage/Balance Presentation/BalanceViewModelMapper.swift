//
//  BalanceViewModelMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/20/23.
//

import Foundation

public class BalanceViewModelMapper {
    
    private enum Error: Swift.Error {
        case amount
    }
    
    public static func map(_ balance: Balance) throws -> BalanceViewModel {
        guard balance.amount >= 0 else { throw Error.amount }
        return BalanceViewModel(amount: balance.amount)
    }
}
