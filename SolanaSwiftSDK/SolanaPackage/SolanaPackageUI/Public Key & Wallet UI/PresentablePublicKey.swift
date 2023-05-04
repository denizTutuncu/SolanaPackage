//
//  PresentableWallet.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import Foundation

public struct PresentablePublicKey: Hashable {
    public init(id: UUID = UUID(), key: String) {
        self.id = id
        self.key = key
    }
    
    public let id: UUID
    public let key: String
    public var isSelected = false
    
    mutating func toggleSelection() {
        isSelected.toggle()
    }
}
