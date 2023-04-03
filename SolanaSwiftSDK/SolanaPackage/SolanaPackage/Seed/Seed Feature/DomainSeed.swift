//
//  DomainSeed.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct DomainSeed: Hashable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
