//
//  PresentableAsset.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/25.
//

import Foundation

public struct PresentableAsset: Hashable {
    public init(id: UUID = UUID(), name: String, assetPrices: [AssetPrice], imageURL: String) {
        self.id = id
        self.name = name
        self.assetPrices = assetPrices
        self.imageURL = imageURL
    }
    
    public let id: UUID
    public let name: String
    public let assetPrices: [AssetPrice]
    public let imageURL: String
    
    public var isSelected = false
    
    mutating func toggleSelection() {
        isSelected.toggle()
    }
}

public struct AssetPrice: Hashable {
    public init(id: UUID = UUID(), date: Date, price: Double) {
        self.id = id
        self.price = price
        self.date = date
    }
    public let id: UUID
    public let date: Date
    public let price: Double
}
