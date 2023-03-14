//
//  iOSSwiftUINavigationAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/16/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

final class iOSSwiftUINavigationAdapter: WalletDelegate {
    typealias Wallet = DomainWallet
    typealias Seed  = DomainSeed
    typealias Transaction = DomainTransaction
    
    private let navigation: BankNavigationStore
    private let wallets: [Wallet]
    private let seed: Seed
    private let loadAgain: () -> Void
    
    init(navigation: BankNavigationStore, wallets: [Wallet], seed: Seed, loadAgain: @escaping () -> Void) {
        self.navigation = navigation
        self.wallets = wallets
        self.seed = seed
        self.loadAgain = loadAgain
    }
    
    func didComplete(with: [Wallet]) {
        let balanceTitle = BalancePresenter.title
        let currencyName = WalletPresenter.currency
    
        let transactionListTitle = TransactionPresenter.listTitle
        let transactionListSubtitle = TransactionPresenter.listSubtitle
        let networkName = WalletPresenter.network
        
        withAnimation {
            navigation.currentView = .wallet(
                //MARK: - To Do // Gotta to call the Composer.
                WalletUIComposer.walletComposedWith(balanceTitle: balanceTitle,
                                                    currencyName: currencyName,
                                                    transactionListTitle: transactionListTitle,
                                                    transactionListSubtitle: transactionListSubtitle,
                                                    network: networkName)
                
            )
        }
        
    }
    
    func didComplete(with: Seed, completion: @escaping ([Wallet]) -> Void) {
        let title = SeedPresenter.title
        let subtitle = SeedPresenter.subtitle
        let toogleOFFTitle = "My phrase is not safe yet."
        let toogleisONTitle = "My phrase is safe now."
        let buttonTitle = "Create wallet"
        
        withAnimation {
            navigation.currentView = .seed(
                SeedUIComposer.seedComposedWith(listTitle: title,
                                                listSubtitle: subtitle,
                                                toogleOFFTitle: toogleOFFTitle,
                                                toogleisONTitle: toogleisONTitle,
                                                buttonTitle: buttonTitle)
                
            )
        }
    }
        
}
