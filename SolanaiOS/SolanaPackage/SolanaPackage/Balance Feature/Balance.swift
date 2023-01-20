//
//  Balance.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import Foundation

public struct Balance: Equatable, Hashable {
    public let amount: Int
    public init(amount: Int) {
        self.amount = amount
    }
}
