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
    
    public static func start<Delegate: WalletDelegate>(delegate: Delegate, wallets: [Delegate.Wallet]) -> Bank where Delegate.Wallet: Equatable{
        let flow = AppStartFlow(delegate: delegate, wallets: wallets)
        flow.start()
        return Bank(flow: flow)
    }
}
