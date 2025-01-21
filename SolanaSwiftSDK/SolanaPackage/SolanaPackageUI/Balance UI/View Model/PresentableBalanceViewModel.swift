//
//  PresentableBalanceViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/17/23.
//

import Foundation

import Foundation

public final class PresentableBalanceViewModel: ObservableObject {
    public init(model: PresentableBalance = PresentableBalance(value: "0.000"), isLoading: Bool = false, errorMessage: String? = nil) {
        self.model = model
        self.isLoading = isLoading
        self.errorMessage = errorMessage
    }
    
    @Published var model: PresentableBalance
    @Published var isLoading: Bool
    @Published var errorMessage: String?

    public func updateBalance(_ balance: PresentableBalance) {
        self.model = balance
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

