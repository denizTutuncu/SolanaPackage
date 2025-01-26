//
//  ReceiveSOLViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import Foundation
import CoreImage.CIFilterBuiltins

public class ReceiveSOLViewModel: ObservableObject {
    @Published var model: ReceiveSOLModel
    @Published var isLoading: Bool

    public init(model: ReceiveSOLModel, isLoading: Bool = false) {
        self.model = model
        self.isLoading = isLoading
    }

    public func updateReceiverPublicKey(_ newKey: String) {
        guard !newKey.isEmpty else { return }
        model = ReceiveSOLModel(address: newKey, qrCodeData: model.qrCodeData)
    }

    public func updateQRCodeData(_ newData: Data) {
        guard !newData.isEmpty else { return }
        model = ReceiveSOLModel(address: model.address, qrCodeData: newData)
    }

    public func setLoading() {
        isLoading = true
    }

    public func setOffLoading() {
        isLoading = false
    }
}
