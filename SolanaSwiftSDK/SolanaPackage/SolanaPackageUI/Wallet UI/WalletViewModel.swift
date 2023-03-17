//
//  WalletStore.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public struct WalletViewModel {
    public var wallets: [WalletUI]
    
    public var wallet: WalletUI? {
        get {
            return wallets.first
        }
        set {
            // Deselect any previously selected wallet
            wallets.indices.forEach { index in
                wallets[index].isSelected = false
            }
            
            // Select the new wallet
            if let newWallet = newValue {
                if let index = wallets.firstIndex(where: { $0.id == newWallet.id && $0.publicKey == newValue?.publicKey && $0.balance == newValue?.balance }) {
                    wallets[index].isSelected = true
                }
            }
        }
    }

    var canSubmit: Bool {
        wallets.contains { $0.isSelected }
    }
    
    private let handler: (WalletUI) -> Void
    
    public init(wallets: [WalletUI]?, handler: @escaping (WalletUI) -> Void) {
        self.wallets = wallets ?? []
        self.handler = handler
    }
    
    public func submit() {
        guard canSubmit else { return }
        guard let selectedWallet = wallets.first(where: { $0.isSelected }) else { return }
        handler(selectedWallet)
    }
}

public struct WalletUI: Hashable {
    let id: UUID
    let publicKey: String
    let balance: String
    
    public init(id: UUID, publicKey: String, balance: String) {
        self.id = id
        self.publicKey = publicKey
        self.balance = balance
    }
    
    var isSelected = false
    
    public mutating func toggleSelection() -> WalletUI {
        isSelected.toggle()
        return self
    }
}
