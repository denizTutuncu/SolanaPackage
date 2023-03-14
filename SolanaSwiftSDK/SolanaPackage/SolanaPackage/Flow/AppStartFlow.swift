//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<Delegate: WalletDelegate>{
    public typealias Wallet = Delegate.Wallet
    public typealias Seed = Delegate.Seed
    
    private var wallets: [Wallet]
    private let seed: Seed
    private let delegate: Delegate
  
    public init(wallets: [Wallet], seeds: Seed, delegate: Delegate) {
        self.wallets = wallets
        self.seed = seeds
        self.delegate = delegate
    }
    
    public func start() {
        delegateHandlingWallets(at: wallets.startIndex)
    }
    
    private func delegateHandlingWallets(at index: Int) {
        if index < wallets.endIndex {
            delegate.didComplete(with: wallets)
        } else {
            delegate.didComplete(with: seed, completion: wallets(at: index))
        }
    }
    
    
    private func delegateExistingWalletHandling(after index: Int) {
        delegateHandlingWallets(at: wallets.index(after: index))
    }
    
    private func wallets(at index: Int) -> ([Wallet]) -> Void {
        return { [weak self] wallets in
            for (index,wallet) in wallets.enumerated() {
                self?.wallets.replaceOrInsert(wallet, at: index)
            }
            self?.delegateExistingWalletHandling(after: index)
        }
    }
 
}

private extension Array {
    mutating func replaceOrInsert(_ element: Element, at index: Index) {
        if index < count {
            remove(at: index)
        }
        insert(element, at: index)
    }
}
