//
//  WalletStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct PublicKeyViewModel {
    
    public init(publicKeys: [PresentablePublicKey],
                handler: @escaping (PresentablePublicKey) -> Void)
    {
        self.publicKeys = publicKeys
        self.handler = handler
    }
    
    public var publicKeys: [PresentablePublicKey]
    
    public var publicKey: PresentablePublicKey? {
        get {
            return publicKeys.first
        }
        set {
            publicKeys.indices.forEach { index in
                publicKeys[index].isSelected = false
            }
            
            if let newWallet = newValue {
                if let index = publicKeys.firstIndex(where: { $0.id == newWallet.id && $0.id == newValue?.id }) {
                    publicKeys[index].isSelected = true
                }
            }
        }
    }

    var canSubmit: Bool {
        publicKeys.contains { $0.isSelected }
    }
    
    public var onLoadingState: Bool {
        self.publicKeys.isEmpty
    }
    
    private let handler: (PresentablePublicKey) -> Void
    
    public func submit() {
        guard canSubmit else { return }
        guard let selectedPublicKey = publicKeys.first(where: { $0.isSelected }) else { return }
        handler(selectedPublicKey)
    }
}
