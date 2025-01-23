//
//  SeedViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation

public class SeedViewModel: ObservableObject {
    @Published var model: [PresentableSeed]
    @Published var isLoading: Bool

    public init(model: [PresentableSeed] = [], isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }

    public var canSubmit: Bool {
        model.allSatisfy { !$0.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && $0.isSafe }
    }

    public func setLoading() {
        isLoading = true
    }
}
