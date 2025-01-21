//
//  SeedListViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/24/23.
//

import Foundation

public final class SeedListViewModel: ObservableObject {
    public init(model: [PresentableSeed] = [], isLoading: Bool = false, errorMessage: String? = nil) {
        self.model = model
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    @Published var model: [PresentableSeed]
    @Published var isLoading: Bool
    @Published var errorMessage: String?

    public var canSubmit: Bool {
        model.allSatisfy { $0.isSafe }
    }
    
    public func updateModel(_ seeds: [String]) {
        self.model = seeds.map { PresentableSeed(value: $0) }
        self.isLoading = false
        self.errorMessage = nil
    }

    public func setError(_ message: String) {
        self.isLoading = false
        self.errorMessage = message
    }

    public func setLoading() {
        self.isLoading = true
        self.errorMessage = nil
    }
    
    public func updateSeed(at index: Int, with seed: PresentableSeed) {
        model[index] = seed // Update the specific seed
        model = model       // Reassign the array to trigger updates
    }
}
