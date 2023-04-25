//
//  SeedStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/24/23.
//

import Foundation

public struct SeedViewModel {
    
    public init(seed: [PresentableSeed], handler: @escaping ([PresentableSeed]) -> Void) {
        self.seed = seed
        self.handler = handler
    }
    
    public var seed: [PresentableSeed]
    
    public var canSubmit: Bool {
        seed.map { $0.isSafe }.allSatisfy { $0 == true }
    }
        
    private let handler: ([PresentableSeed]) -> Void
    
    public func submit() {
        guard canSubmit else { return }
        return handler(seed)
    }
    
}
