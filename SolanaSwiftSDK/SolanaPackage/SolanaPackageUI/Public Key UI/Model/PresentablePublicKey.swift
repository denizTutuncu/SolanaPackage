//
//  PresentablePublicKey.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import Foundation

public struct PresentablePublicKey: Hashable {
    public init(id: UUID = UUID(), value: String) {
        self.id = id
        self.value = value
    }
    
    public let id: UUID
    public let value: String
    public var isSelected = false
    
    mutating func toggleSelection() {
        isSelected.toggle()
    }
}
