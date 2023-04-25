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
    
    public static func start<PubKeyDelegate: PublicKeyDelegate, SDelegate: SeedDelegate>
    (
        publicKeysDelegate: PubKeyDelegate,
        publicKeys: [String],
        seedDelegate: SDelegate,
        seed: [String]
    ) -> Bank {
        
        let flow = AppStartFlow(publicKeys: publicKeys, seed: seed, publicKeyDelegate: publicKeysDelegate, seedDelegate: seedDelegate)
        flow.start()
        return Bank(flow: flow)
    }
}
