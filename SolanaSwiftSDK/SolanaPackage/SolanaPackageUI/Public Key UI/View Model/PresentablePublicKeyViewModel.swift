//
//  PresentablePublicKeyViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public final class PresentablePublicKeyViewModel: ObservableObject {
    public init(model: [PresentablePublicKey] = [], isLoading: Bool = true, errorMessage: String? = nil) {
        self.model = model
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    @Published var model: [PresentablePublicKey]
    @Published var isLoading: Bool
    @Published var errorMessage: String?

    public func updateModel(_ keys: [PresentablePublicKey]) {
        self.model = keys
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
}
