//
//  Balance.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import Foundation

public struct Balance: Equatable, Hashable {
    public let value: Int
    public init(value: Int) {
        self.value = value
    }
}
