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
    
    public static func start<WDelegate: PublicKeyDelegate, SDelegate: SeedDelegate>
    (
        publicKeysDelegate: WDelegate,
        publicKeys: [WDelegate.PublicKey],
        seedDelegate: SDelegate,
        seed: [SDelegate.Seed]
        
    ) -> Bank where WDelegate.PublicKey: Equatable, SDelegate.Seed: Equatable {
        
        let flow = AppStartFlow(publicKeys:         publicKeys, seed: seed, publicKeyDelegate:         publicKeysDelegate, seedDelegate: seedDelegate)
        flow.start()
        return Bank(flow: flow)
    }
}
