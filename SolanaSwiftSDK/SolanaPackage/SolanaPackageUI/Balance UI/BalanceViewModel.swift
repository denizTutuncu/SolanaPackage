//
//  BalanceViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/17/23.
//

import Foundation

public struct BalanceViewModel {
    
    public init(model: PresentableBalance) {
        self.model = model
    }
    public let model: PresentableBalance
    
    public var isModelEmpty: Bool {
        return model.value.isEmpty
    }
}
