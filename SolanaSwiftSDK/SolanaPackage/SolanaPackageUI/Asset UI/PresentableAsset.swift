//
//  PresentableAsset.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/25.
//

import Foundation

public struct PresentableAsset: Hashable {
    public init(id: UUID = UUID(), name: String, price: String, imageURL: String) {
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
    
    public let id: UUID
    public let name: String
    public let price: String
    public let imageURL: String
    
    public var isSelected = false
    
    mutating func toggleSelection() {
        isSelected.toggle()
    }
}
