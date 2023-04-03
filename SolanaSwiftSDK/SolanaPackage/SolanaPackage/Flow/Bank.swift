//
//  Flow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class Bank {
    private let flow: Any
    
    private init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<WDelegate: WalletDelegate, SDelegate: SeedDelegate>
    (
        walletDelegate: WDelegate,
        wallets: [WDelegate.Wallet],
        seedDelegate: SDelegate,
        seed: [SDelegate.Seed]
        
    ) -> Bank where WDelegate.Wallet: Equatable, SDelegate.Seed: Equatable {
        
        let flow = AppStartFlow(wallets: wallets, seed: seed, walletDelegate: walletDelegate, seedDelegate: seedDelegate)
        flow.start()
        return Bank(flow: flow)
    }
}
