//
//  SeedStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/24/23.
//

import Foundation

public struct SeedViewModel {
    public var seed: [SeedUI]
        
    public init(seed: [SeedUI]?) {
        self.seed = seed ?? []
    }
    
}

public struct SeedUI {
    public let id: UUID
    public let value: String
    
    public init(id: UUID = UUID(), value: String) {
        self.id = id
        self.value = value
    }
}

