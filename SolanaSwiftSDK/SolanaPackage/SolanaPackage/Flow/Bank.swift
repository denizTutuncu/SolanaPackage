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
    
    public static func start<Delegate: WalletDelegate>(wallets: [String], walletLoader: LocalWalletLoader, delegate: Delegate, seeds: [String]) -> Bank {
        let flow = AppStartFlow(wallets: wallets, walletLoader: walletLoader, seeds: seeds, delegate: delegate)
        flow.start()
        return Bank(flow: flow)
    }
}
