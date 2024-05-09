//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<PKDelegate: PublicKeyDelegate, SDelegate: SeedDelegate>{
    
    public init(publickeys: [PublicKey],
                seed: [Seed],
                pkDelegate: PKDelegate,
                sDelegate: SDelegate
    ) {
        self.publickeys = publickeys
        self.seed = seed
        self.pkDelegate = pkDelegate
        self.sDelegate = sDelegate
    }
    
    public typealias PublicKey = String
    public typealias Seed = String
    
    private let publickeys: [PublicKey]
    private let seed: [Seed]
    private let pkDelegate: PublicKeyDelegate
    private let sDelegate: SeedDelegate
  
    public func start() {
        delegateHandlingPublickeys(at: publickeys.startIndex)
    }
    
    private func delegateHandlingPublickeys(at index: Int) {
        if index < publickeys.endIndex {
            pkDelegate.didCompleteWith(keys: publickeys)
        } else {
            sDelegate.didCompleteWith(seed: seed)
        }
    }
        
}
