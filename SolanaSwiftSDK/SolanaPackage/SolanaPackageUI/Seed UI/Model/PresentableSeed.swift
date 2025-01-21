//
//  PresentableSeed.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import Foundation

public struct PresentableSeed {
    
    public init(id: UUID = UUID(), value: String) {
        self.id = id
        self.value = value
    }
    
    public let id: UUID
    public var value: String
    
    var isSafe = false
    
    public mutating func toggleSelection() -> PresentableSeed {
        isSafe.toggle()
        return self
    }
}
