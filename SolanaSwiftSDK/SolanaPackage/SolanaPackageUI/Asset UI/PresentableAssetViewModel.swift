//
//  PresentableAssetViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/13/25.
//

import Foundation

public struct PresentableAssetViewModel {
    public init(model: [PresentableAsset] = []) {
        self.model = model.map{ PresentableAsset(name: $0.name, price: $0.price, imageURL: $0.imageURL) }
    }
    
    public let model: [PresentableAsset]
        
    public var isModelEmpty: Bool {
        return model.isEmpty
    }
}
