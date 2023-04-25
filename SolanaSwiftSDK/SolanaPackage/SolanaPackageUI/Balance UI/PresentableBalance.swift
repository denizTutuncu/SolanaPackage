//
//  PresentableBalance.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/17/23.
//

import Foundation

public struct PresentableBalance: Hashable {
    let id: UUID
    let value: String
    
    public init(id: UUID = UUID(), value: String) {
        self.id = id
        self.value = value
    }
}
