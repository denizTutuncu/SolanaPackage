//
//  BalanceErrorViewModel.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import Foundation

public struct BalanceErrorViewModel {
    public let error: String?
    
    static var noError: BalanceErrorViewModel {
        return BalanceErrorViewModel(error: .none)
    }
    
    static func error(message: String) -> BalanceErrorViewModel {
        return BalanceErrorViewModel(error: message)
    }
}
