//
//  iOSSwiftUINavigationAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/16/23.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI

final class iOSSwiftUINavigationAdapter: WalletDelegate {
    typealias Wallet = DomainWallet
    
    private let navigation: BankNavigationStore
    private let wallets: [Wallet]
    private let loadAgain: () -> Void
    
    private var publicKeys: [String] {
        return wallets.map { $0.publicKey }
    }
    
    init(navigation: BankNavigationStore, wallets: [Wallet], loadAgain: @escaping () -> Void) {
        self.navigation = navigation
        self.wallets = wallets
        self.loadAgain = loadAgain
    }
    
    func navigate(from: Wallet, completion: @escaping (Wallet) -> Void) {
        let title = WalletPresenter.title
        let currencyName = WalletPresenter.currencyName
        
        withAnimation {
            navigation.currentView = .balance( BalanceView(title: title, amount: "\(from.balance)", currencyName: currencyName))
        }
    }
    
}
