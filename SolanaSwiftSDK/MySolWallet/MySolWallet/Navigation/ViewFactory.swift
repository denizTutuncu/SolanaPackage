//
//  ViewFactory.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

class ViewFactory {
    static func makeOnboardingView(seeds: [PresentableSeed], coordinator: NavigationCoordinator) -> OnboardingView {
        OnboardingView(
            headerTitle: "Welcome to Blue Giant Labs",
            headerTitleTextColor: .white,
            headerSubtitle: "Providing head-to-head asset comparisons to help users make informed choices in the volatile Solana market.",
            headerSubtitleTextColor: .blue,
            backgroundImageName: "OnboardingBackground",
            logoImageName: "OnboardingAppLogo",
            bundle: "com.deniztutuncu.SolanaPackageUI",
            firstButtonTitle: "Create Wallet",
            firstButtonAction: {
                coordinator.navigateToExportSeed(seeds: seeds)
            },
            secondButtonTitle: "Import Wallet",
            secondButtonAction: {
                coordinator.navigateToImportSeed(seeds: seeds)
            }
        )
    }

    static func makeExportSeedView(seeds: [PresentableSeed], coordinator: NavigationCoordinator) -> ExportSeedView {
        ExportSeedView(
            viewModel: .init(model: seeds, isLoading: seeds.isEmpty),
            headerTitle: SeedPresenter.exportSeedViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: SeedPresenter.exportSeedViewSubtitle,
            headerSubtitleTextColor: .blue,
            buttonTitle: SeedPresenter.exportSeedViewButtonTitle,
            errorMessage: SeedPresenter.exportSeedViewErrorMessage,
            errorViewButtonTitle: SeedPresenter.exportSeedViewErrorButtonTitle,
            loadingTitle: SeedPresenter.exportSeedViewLoadingTitle,
            loadAgain: { print("Load again button triggered") },
            action: { coordinator.navigateToOnboarding(with: seeds) },
            backButtonTitle: "Back",
            backAction: { coordinator.navigateToOnboarding(with: seeds) }
        )
    }

    static func makeImportSeedView(seeds: [PresentableSeed], coordinator: NavigationCoordinator) -> ImportSeedView {
        ImportSeedView(
            viewModel: .init(model: seeds, isLoading: false),
            headerTitle: SeedPresenter.importSeedViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: SeedPresenter.importSeedViewSubtitle,
            headerSubtitleTextColor: .blue,
            buttonTitle: SeedPresenter.importSeedViewButtonTitle,
            errorMessage: SeedPresenter.importSeedViewErrorMessage,
            errorViewButtonTitle: SeedPresenter.importSeedViewErrorButtonTitle,
            loadingTitle: SeedPresenter.importSeedViewLoadingTitle,
            loadAgain: { print("Load again button triggered") },
            action: { print("Action button triggered") },
            backButtonTitle: "Back",
            backAction: {coordinator.navigateToOnboarding(with: seeds) }
        )
    }

    static func makeWalletListView(publicKeys: [PresentablePublicKey],
                                   transactions: [PresentableTransaction],
                                   balance: PresentableBalance,
                                   coordinator: NavigationCoordinator) -> WalletListView {
        WalletListView(
            headerTitle: WalletPresenter.walletListViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: WalletPresenter.walletListViewSubtitle,
            headerSubtitleTextColor: .blue,
            errorMessage: WalletPresenter.walletListViewErrorMessage,
            errorViewButtonTitle: WalletPresenter.walletListErrorButtonTitle,
            loadingTitle: WalletPresenter.walletListViewLoadingTitle,
            tryAgain: { coordinator.navigateToOnboarding(with: []) },
            selection: { publicKey in
                coordinator.navigateToWalletDetail(
                    publicKey: PresentablePublicKey(value: publicKey),
                    transactions: transactions,
                    balance: balance
                )
            },
            viewModel: .init(model: publicKeys, isLoading: publicKeys.isEmpty, errorMessage: WalletPresenter.walletListViewErrorMessage)
        )
    }

    static func makeWalletDetailView(publicKey: PresentablePublicKey,
                                     transactions: [PresentableTransaction],
                                     balance: PresentableBalance,
                                     coordinator: NavigationCoordinator) -> WalletDetailView {
        WalletDetailView(
            publicKey: publicKey.value,
            network: WalletPresenter.network,
            currency: WalletPresenter.currency,
            balanceLabelTitle: "Balance:",
            balanceLoadingTitle: "Loading balance...",
            balanceErrorMessage: "Cannot load balance",
            balanceErrorButtonTitle: "Try again",
            transactionListTitle: "Transactions",
            transactionListSubtitle: "Recent transactions",
            transactionLoadingTitle: "Loading transactions...",
            transactionErrorMessage: "Cannot load transactions",
            transactionErrorButtonTitle: "Try again",
            transactionSelection: { transactionID in },
            tryLoadBalance: { balanceValue in },
            tryLoadTransactions: { print("Try load transactions button triggered") },
            balanceViewModel: .init(model: balance, isLoading: false, errorMessage: nil),
            transactionListViewModel: .init(model: transactions, isLoading: transactions.isEmpty, errorMessage: "Cannot load transactions")
        )
    }
}
