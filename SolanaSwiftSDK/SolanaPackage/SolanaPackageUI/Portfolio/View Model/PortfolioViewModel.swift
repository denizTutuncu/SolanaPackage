//
//  PortfolioViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/24/25.
//

import Foundation

public class PortfolioViewModel: ObservableObject {
    @Published var model: [Portfolio]
    @Published var isLoading: Bool

    public init(model: [Portfolio] = [], isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }
    
    public func setLoading() {
        isLoading = true
    }
}
