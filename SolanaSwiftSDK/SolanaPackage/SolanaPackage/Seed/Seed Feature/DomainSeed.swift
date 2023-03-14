//
//  DomainSeed.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct DomainSeed: Hashable {
    public let id: UUID
    public let seed: [String]

    public init(id: UUID, seed: [String]) {
        self.id = id
        self.seed = seed
    }
}
