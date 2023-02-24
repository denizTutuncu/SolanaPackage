//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

final class AppStartFlow<Delegate: WalletDelegate>{
    typealias Wallet = Delegate.Wallet
    
    private let delegate: Delegate
    private var wallets: [Wallet]
    
    init(delegate: Delegate, wallets: [Wallet]) {
        self.delegate = delegate
        self.wallets = wallets
    }
    
    func start() {
        delegateWalletHandling(at: wallets.startIndex)
    }
    
    private func delegateWalletHandling(at index: Int) {
        if index < wallets.endIndex {
            let wallet = wallets[index]
            delegate.navigate(from: wallet, completion: perform(wallet, at: index))
        }
    }
    
    private func perform( _ from: Wallet, at index: Int) -> (Wallet) -> Void {
        return { [weak self] wallet in
            self?.wallets.replaceOrInsert(wallet, at: index)
            self?.delegateWalletHandling(after: index)
        }
    }
    
    private func delegateWalletHandling(after index: Int) {
        delegateWalletHandling(at: wallets.index(after: index))
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
