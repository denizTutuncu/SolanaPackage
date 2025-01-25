//
//  PresentableAsset.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/25.
//

import Foundation

public struct PresentableAsset: Hashable {
    public init(id: UUID = UUID(), name: String, prices: [Double], imageURL: String) {
        self.id = id
        self.name = name
        self.prices = prices
        self.imageURL = imageURL
    }
    
    public let id: UUID
    public let name: String
    public let prices: [Double]
    public let imageURL: String
    
    public var isSelected = false
    
    mutating func toggleSelection() {
        isSelected.toggle()
    }
}
