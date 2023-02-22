//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

final class AppStartFlow<Delegate: WalletDelegate>{
    private let delegate: Delegate
    private let walletLoader: LocalWalletLoader
    
    private let wallets: [String]
    private var publicKeys: [String] = []
    private var seeds: [String] = []
    
    init(wallets: [String], walletLoader: LocalWalletLoader, seeds: [String], delegate: Delegate) {
        self.wallets = wallets
        self.walletLoader = walletLoader
        self.seeds = seeds
        self.delegate = delegate
    }
    
    func start() {
        delegateWalletHandling(at: wallets.startIndex)
    }
    
    private func delegateWalletHandling(at index: Int) {
        if wallets.count == 0 {
            delegate.navigateToWalletCreation(from: seeds, completion: publicKey(at: index))
            
        } else {
            let wallets = try! walletLoader.load()
//            delegate.loadWallet
                
        }
    }
    
    private func publicKey(at index: Int) -> (String) -> Void {
        return { [weak self] publicKey in
            self?.publicKeys.replaceOrInsert(publicKey, at: index)
            self?.delegateWalletHandling(after: index)
        }
    }
    

    private func delegateWalletHandling(after index: Int) {
        delegateWalletHandling(at: wallets.index(after: index))
    }
}

private extension Array {
    mutating func replaceOrInsert(_ element: Element? = nil, at index: Index) {
        if index < count {
            remove(at: index)
        }
        if let element = element {
            insert(element, at: index)
        }
    }
}
