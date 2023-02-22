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
    typealias PublicKey = String
    typealias Seed = [String]
    typealias Wallets = [Wallet]
    
    
    private let navigation: BankNavigationStore
    private let wallets: Wallets
    private let seed: Seed
    private let loadAgain: () -> Void
    
    private var pubKeys: [PublicKey] {
        return wallets.map { $0.publicKey }
    }

    init(navigation: BankNavigationStore, wallets: Wallets, seed: Seed, loadAgain: @escaping () -> Void) {
        self.navigation = navigation
        self.wallets = wallets
        self.seed = seed
        self.loadAgain = loadAgain
    }
    
    func navigateToWalletCreation(from seeds: [String], completion: @escaping (String) -> Void) {
        //MARK: - Implement
    }
    
    func navigateTo(wallet: Wallet, completion: @escaping ([String]) -> Void) {
        let title = WalletPresenter.title
        let currencyName = WalletPresenter.currencyName
        
        withAnimation {
            navigation.currentView = .balance( BalanceView(title: title, amount: "\(wallet.balance)", currencyName: currencyName))
        }
    }
    
}
