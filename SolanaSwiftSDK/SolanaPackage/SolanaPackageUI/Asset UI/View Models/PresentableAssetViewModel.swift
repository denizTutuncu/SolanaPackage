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
        guard let minPrice = model.assetDailyData.min(by: { $0.low < $1.low })?.low,
              let maxPrice = model.assetDailyData.max(by: { $0.high < $1.high })?.high else {
            return nil
        }
        return (minPrice - 10)...(maxPrice + 10)
    }
}

