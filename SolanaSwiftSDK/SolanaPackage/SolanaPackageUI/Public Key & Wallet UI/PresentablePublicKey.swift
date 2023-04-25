//
//  PresentableWallet.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import Foundation

public struct PresentablePublicKey: Hashable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
    
    var isSelected = false
    
    public mutating func toggleSelection() -> PresentablePublicKey {
        isSelected.toggle()
        return self
    }
}
