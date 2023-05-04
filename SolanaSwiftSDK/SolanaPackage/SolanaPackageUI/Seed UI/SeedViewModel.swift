//
//  SeedStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/24/23.
//

import Foundation

public struct SeedViewModel {
    
    public init(model: [String] = [], handler: @escaping ([String]) -> Void) {
        self.model = model.map { PresentableSeed(value: $0) }
        self.handler = handler
    }
    
    public var model: [PresentableSeed]
    
    public var canSubmit: Bool {
        model.map { $0.isSafe }.allSatisfy { $0 == true }
    }
        
    private let handler: ([String]) -> Void
    
    public func submit() {
        guard canSubmit else { return }
        return handler(model.map { $0.value })
    }
    
    public var isModelEmpty: Bool {
        return model.isEmpty
    }
}
