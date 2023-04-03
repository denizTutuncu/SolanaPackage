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
        selection: @escaping (String) -> Void = { _ in },
        wallets: [DomainWallet] = [],
        transactions: [DomainTransaction] = []
    ) -> WalletView {
        let walletPublisher = WalletStorePublisher(resource: wallets, mapper: WalletStoreMapper.map)
        let transactionPublisher = TransactionStorePublisher(resource: transactions, mapper: TransactionStoreMapper.map)
        
        let walletView = makeWalletView(balanceTitle: balanceTitle,
                                        currencyName: currency,
                                        network: network,
                                        transactionListTitle: transactionListTitle,
                                        transactionListSubtitle: transactionListSubtitle,
                                        selection: selection,
                                        walletViewModel: .init(wallets: walletPublisher.onResourceLoad,
                                                           handler: { wallet in }),
                                        transactionViewModel: .init(transactions: transactionPublisher.onResourceLoad))
                                      
        return walletView
    }
    
    private static func makeWalletView(balanceTitle: String,
                                       currencyName: String,
                                       network: String,
                                       transactionListTitle: String,
                                       transactionListSubtitle: String,
                                       selection: @escaping (String) -> Void = { _ in },
                                       walletViewModel: WalletViewModel,
                                       transactionViewModel: TransactionViewModel)
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
                                  transactionSelection: selection,
                                  walletViewModel: walletViewModel,
                                  transactionViewModel: transactionViewModel)
        return walletView
    }
}


