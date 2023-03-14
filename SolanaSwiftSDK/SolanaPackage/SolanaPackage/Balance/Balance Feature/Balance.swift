//
//  Balance.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import Foundation

public struct Balance: Equatable, Hashable {
    public init(amount: Double) {
        self.amount = amount
    }
    
    public let amount: Double
}
