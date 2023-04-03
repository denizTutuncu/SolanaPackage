//
//  HardcodedSeedStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation

extension HardcodedSeedStore: SeedBankStore {
    public func loadBank() throws -> [String] {
        return seed
    }
}

final public class HardcodedSeedStore {
    public init(seed: [String]) {
        self.seed = seed
    }
    
    private let seed: [String]
}
