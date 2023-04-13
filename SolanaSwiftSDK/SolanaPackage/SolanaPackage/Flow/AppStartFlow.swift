//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<WD: PublicKeyDelegate, SD: SeedDelegate>{
    public typealias PublicKey = WD.PublicKey
    public typealias Seed = SD.Seed
    
    private var publicKeys: [PublicKey]
    private let seed: [Seed]
    private let walletDelegate: WD
    private let seedDelegate: SD
    
    public init(publicKeys: [PublicKey], seed: [Seed], walletDelegate: WD, seedDelegate: SD) {
        self.publicKeys = publicKeys
        self.seed = seed
        self.walletDelegate = walletDelegate
        self.seedDelegate = seedDelegate
    }
    
    public func start() {
        delegateHandlingWallets(at: publicKeys.startIndex)
    }
    
    private func delegateHandlingWallets(at index: Int) {
        if index < publicKeys.endIndex {
            walletDelegate.didComplete(completion: wallets(at: index))
        } else {
            seedDelegate.didComplete(completion: seed)
        }
    }
    
    private func delegateExistingWalletHandling(after index: Int) {
        delegateHandlingWallets(at: publicKeys.index(after: index))
    }
    
    private func wallets(at index: Int) -> ([PublicKey]) -> Void {
        return { [weak self] wallets in
            for (index,wallet) in wallets.enumerated() {
                self?.publicKeys.replaceOrInsert(wallet, at: index)
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
