//
//  WalletViewFactory.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/26/25.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI

final class WalletViewFactory {
    private let navigation: NavigationCoordinator
    private let publicKeyStore: PublicKeyStorePublisher
    private let transactionStore: TransactionStorePublisher
    private let balanceStore: BalanceStorePublisher

    init(navigation: NavigationCoordinator,
         publicKeyStore: PublicKeyStorePublisher,
         transactionStore: TransactionStorePublisher,
         balanceStore: BalanceStorePublisher) {
        self.navigation = navigation
        self.publicKeyStore = publicKeyStore
        self.transactionStore = transactionStore
        self.balanceStore = balanceStore
    }
    
    func makeWalletListView() -> WalletListView {
        WalletListView(
            headerTitle: WalletPresenter.walletListViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: WalletPresenter.walletListViewSubtitle,
            headerSubtitleTextColor: .blue,
            errorMessage: WalletPresenter.walletListViewErrorMessage,
            errorViewButtonTitle: WalletPresenter.walletListErrorButtonTitle,
            loadingTitle: WalletPresenter.walletListViewLoadingTitle,
            tryAgain: {
                print("Reloading wallets...")
                // TODO: Implement reload logic
            },
            selection: { publicKey in
                self.navigation.navigate(to: .walletDetail)
            },
            viewModel: .init(
                model: publicKeyStore.publicKeyViewModelPublisher.resourceViewModel ?? [],
                isLoading: publicKeyStore.publicKeyViewModelPublisher.isLoading,
                errorMessage: WalletPresenter.walletListViewErrorMessage
            )
        )
    }

    func makeWalletDetailView() -> WalletDetailView {
        WalletDetailView(
            publicKey: publicKeyStore.publicKeyViewModelPublisher.resourceViewModel?.first?.value ?? "No Public Key",
            network: WalletPresenter.networkName,
            currency: WalletPresenter.currencyName,
            balanceLabelTitle: "Balance:",
            balanceLoadingTitle: "Loading balance...",
            balanceErrorMessage: "Cannot load balance",
            balanceErrorButtonTitle: "Try again",
            transactionListTitle: "Transaction List",
            transactionListHeaderTitleTextColor: .primary,
            transactionListSubtitle: "Past transactions are stored here.",
            transactionListHeadersubtitleTextColor: .blue,
            transactionLoadingTitle: "Loading transactions...",
            transactionErrorMessage: "Cannot load transactions",
            transactionErrorButtonTitle: "Try again",
            transactionSelection: { transactionID in
                print("Transaction selected: \(transactionID)")
            },
            tryLoadBalance: { _ in
                print("Trying to reload balance...")
                // TODO: Implement balance reload
            },
            tryLoadTransactions: {
                print("Trying to reload transactions...")
                // TODO: Implement transaction reload
            },
            balanceViewModel: PresentableBalanceViewModel(
                model: balanceStore.balanceViewModelPublisher.resourceViewModel ?? PresentableBalance(value: ""),
                isLoading: balanceStore.balanceViewModelPublisher.isLoading,
                errorMessage: nil
            ),
            transactionListViewModel: TransactionListViewModel(
                model: transactionStore.transactionViewModelPublisher.resourceViewModel ?? [],
                isLoading: transactionStore.transactionViewModelPublisher.isLoading,
                errorMessage: "Cannot load transactions"
            )
        )
    }
}
