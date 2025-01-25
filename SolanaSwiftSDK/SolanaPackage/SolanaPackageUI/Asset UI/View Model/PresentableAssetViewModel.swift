//
//  PresentableAssetViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/13/25.
//

import Foundation

public class PresentableAssetViewModel: ObservableObject {
    public init(model: [PresentableAsset] = [], isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }
    
    @Published public var model: [PresentableAsset]
    @Published public var isLoading: Bool

    public var isModelEmpty: Bool {
        return model.isEmpty
    }

    public func setLoading() {
        isLoading = true
    }
}
