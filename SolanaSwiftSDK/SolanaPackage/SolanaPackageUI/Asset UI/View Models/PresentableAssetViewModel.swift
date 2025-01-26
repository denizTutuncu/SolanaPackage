//
//  PresentableAssetViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import Foundation

public class PresentableAssetViewModel: ObservableObject {
    public init(model: PresentableAsset, isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }
    
    @Published public var model: PresentableAsset
    @Published public var isLoading: Bool

    public var isModelEmpty: Bool {
        return model.id.uuidString.isEmpty
    }

    public func setLoading() {
        isLoading = true
    }
}

extension PresentableAssetViewModel {
    var priceRange: ClosedRange<Double>? {
        guard let minPrice = model.assetPrices.min(by: { $0.price < $1.price })?.price,
              let maxPrice = model.assetPrices.max(by: { $0.price < $1.price })?.price else {
            return nil
        }
        return (minPrice - 10)...(maxPrice + 10)
    }
}
