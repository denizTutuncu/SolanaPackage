//
//  Balance.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import Foundation

public struct Balance: Equatable, Hashable {
    public let lamports: Int
    public init(lamports: Int) {
        self.lamports = lamports
    }
}
