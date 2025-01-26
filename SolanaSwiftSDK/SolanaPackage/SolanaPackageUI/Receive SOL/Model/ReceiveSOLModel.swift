//
//  ReceiveSOLModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import Foundation

public struct ReceiveSOLModel {
    
    public init(address: String, qrCodeData: Data) {
        self.address = address
        self.qrCodeData = qrCodeData
    }
    
    public let address: String
    public let qrCodeData: Data
}
