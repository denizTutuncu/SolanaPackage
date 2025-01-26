//
//  TransferViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import Foundation

public class TransferViewModel: ObservableObject {
    @Published var model: TransferModel
    @Published var isLoading: Bool
    
    public init(model: TransferModel, isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }
    
    public func updateRecipientPublicKey(_ newKey: String) {
        guard newKey.isEmpty == true else { return }
        model = TransferModel(recipientPublicKey: newKey, amount: model.amount)
    }
    
    public func updateAmount(_ newAmount: String) {
        guard newAmount.isEmpty == true else { return }
        model = TransferModel(recipientPublicKey: model.recipientPublicKey, amount: newAmount)
    }
    
    public func setLoading() {
        isLoading = true
    }
    
    public func setOffLoading() {
        isLoading = false
    }
}
