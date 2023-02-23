//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

final class AppStartFlow<Delegate: WalletDelegate>{
    typealias Wallet = Delegate.Wallet
    
    private let delegate: Delegate
    private var wallets: [Wallet]
    
    init(delegate: Delegate, wallets: [Wallet]) {
        self.delegate = delegate
        self.wallets = wallets
    }
    
    func start() {
        delegateWalletHandling(at: wallets.startIndex)
    }
    
    private func delegateWalletHandling(at index: Int) {
        if wallets.count == 0 {
            delegate.navigateToWalletCreation()
        } else {
            if let fWallet = wallets.first {
                delegate.navigateToWallet(from: [fWallet])
            }
        }
    }
}
