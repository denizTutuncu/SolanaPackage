//
//  WalletStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct PublicKeyViewModel {
    public init(model: [String] = []) {
        self.model = model.map{ PresentablePublicKey(key: $0) }
    }
    
    public let model: [PresentablePublicKey]
        
    public var isModelEmpty: Bool {
        return model.isEmpty
    }
}
