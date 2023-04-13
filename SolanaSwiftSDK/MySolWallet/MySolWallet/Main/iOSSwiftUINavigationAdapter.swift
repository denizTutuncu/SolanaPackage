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

final class iOSSwiftUINavigationAdapter: PublicKeyDelegate, SeedDelegate {
    typealias PublicKey = DomainWallet
    typealias Seed  = DomainSeed
    typealias Transaction = DomainTransaction
    
    private let navigation: BankNavigationStore
    private let publicKeys: [PublicKey]
    private let seed: [Seed]
    private let loadAgain: () -> Void
    
    init(navigation: BankNavigationStore, publicKeys: [PublicKey], seed: [Seed], loadAgain: @escaping () -> Void) {
        self.navigation = navigation
        self.publicKeys = publicKeys
        self.seed = seed
        self.loadAgain = loadAgain
    }
    
    func didComplete(completion: @escaping ([PublicKey]) -> Void) {
        let balanceTitle = BalancePresenter.title
        let currency = WalletPresenter.currency
        let network = WalletPresenter.network
        let transactionListTitle = TransactionPresenter.listTitle
        let transactionListSubtitle = TransactionPresenter.listSubtitle
        
        
        withAnimation {
            navigation.currentView = .wallet(
                WalletUIComposer.walletComposedWith(balanceTitle: balanceTitle,
                                                    currency: currency,
                                                    network: network,
                                                    transactionListTitle: transactionListTitle,
                                                    transactionListSubtitle: transactionListSubtitle
                                                   )
                
            )
        }
    }
    
    func didComplete(completion: [Seed]) {
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
                                                buttonTitle: buttonTitle,
                                                resource: completion)
            )
        }
    }
    
}
