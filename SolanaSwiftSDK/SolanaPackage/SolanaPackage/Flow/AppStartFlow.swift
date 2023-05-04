//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<Delegate: PublicKeyDelegate>{
    
    public init(publickeys: [PublicKey],
                seed: [Seed],
                delegate: Delegate
    ) {
        self.publickeys = publickeys
        self.seed = seed
        self.delegate = delegate
    }
    
    public typealias PublicKey = String
    public typealias Seed = String
    
    private let publickeys: [PublicKey]
    private let seed: [Seed]
    private let delegate: Delegate
  
    public func start() {
        delegateHandlingPublickeys(at: publickeys.startIndex)
    }
    
    private func delegateHandlingPublickeys(at index: Int) {
        if index < publickeys.endIndex {
            delegate.didCompleteWith(keys: publickeys)
        } else {
            delegate.didCompleteWith(seed: seed)
        }
    }
        
}
