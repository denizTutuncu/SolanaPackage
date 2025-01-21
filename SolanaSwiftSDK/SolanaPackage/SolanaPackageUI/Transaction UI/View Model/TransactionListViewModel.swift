//
//  TransactionListViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/14/25.
//

import Foundation

public final class TransactionListViewModel: ObservableObject {
    public init(model: [PresentableTransaction] = [], isLoading: Bool = true, errorMessage: String? = nil) {
        self.model = model
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    @Published var model: [PresentableTransaction]
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    
    public func updateModel(_ transactions: [PresentableTransaction]) {
        self.model = transactions
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
