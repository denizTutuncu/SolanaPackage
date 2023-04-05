//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<WD: PublicKeyDelegate, SD: SeedDelegate>{
    public typealias Wallet = WD.Wallet
    public typealias Seed = SD.Seed
    
    private var wallets: [Wallet]
    private let seed: [Seed]
    private let walletDelegate: WD
    private let seedDelegate: SD
    
    public init(wallets: [Wallet], seed: [Seed], walletDelegate: WD, seedDelegate: SD) {
        self.wallets = wallets
        self.seed = seed
        self.walletDelegate = walletDelegate
        self.seedDelegate = seedDelegate
    }
    
    public func start() {
        delegateHandlingWallets(at: wallets.startIndex)
    }
    
    private func delegateHandlingWallets(at index: Int) {
        if index < wallets.endIndex {
            walletDelegate.didComplete(completion: wallets(at: index))
        } else {
            seedDelegate.didComplete(completion: seed)
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
