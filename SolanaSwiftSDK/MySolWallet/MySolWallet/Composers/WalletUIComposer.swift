//
//  WalletUIComposer.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 3/3/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

public final class WalletUIComposer {
    private init() {}
    
    private typealias WalletStorePublisher = ViewModelPublisher<[DomainWallet], [WalletUI]>
    private typealias TransactionStorePublisher = ViewModelPublisher<[DomainTransaction], [TransactionUI]>
    
    public static func walletComposedWith(
        balanceTitle: String,
        currency: String,
        network: String,
        transactionListTitle: String,
        transactionListSubtitle: String,
        selection: @escaping (String) -> Void = { _ in }
    ) -> WalletView {
        let walletPublisher = WalletStorePublisher(resource: <#[DomainWallet]?#>, mapper: WalletStoreMapper.map)
        let transactionPublisher = TransactionStorePublisher(resource: <#[DomainTransaction]?#>, mapper: TransactionStoreMapper.map)
        
        let walletView = makeWalletView(balanceTitle: balanceTitle,
                                        currencyName: currencyName,
                                        transactionListTitle: transactionListTitle,
                                        transactionListSubtitle: transactionListSubtitle,
                                        network: network,
                                        selection: selection,
                                        walletStore: .init(wallets: walletPublisher.onResourceLoad,
                                                           handler: { wallet in }),
                                        transactionStore: .init(transactions: transactionPublisher.onResourceLoad))
                                      
        return walletView
    }
    
    private static func makeWalletView(balanceTitle: String,
                                       currencyName: String,
                                       transactionListTitle: String,
                                       transactionListSubtitle: String,
                                       network: String,
                                       selection: @escaping (String) -> Void = { _ in },
                                       walletStore: WalletStore,
                                       transactionStore: TransactionStore)
    -> WalletView {
        
        let balanceTitle = BalancePresenter.title
        let currencyName = WalletPresenter.currency
        let transactionListTitle = TransactionPresenter.listTitle
        let transactionListSubtitle = TransactionPresenter.listSubtitle
        let networkName = WalletPresenter.network
        
        
        let walletView = WalletView(balanceLabelTitle: balanceTitle,
                                  currencyName: currencyName,
                                  transactionListTitle: transactionListTitle,
                                  transactionListSubtitle: transactionListSubtitle,
                                  network: networkName,
                                  selection: selection,
                                  walletStore: walletStore,
                                  transactionStore: transactionStore)
        return walletView
    }
}


