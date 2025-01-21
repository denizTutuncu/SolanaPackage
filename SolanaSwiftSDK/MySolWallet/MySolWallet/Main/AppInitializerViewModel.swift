//
//  AppInitializerViewModel.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/20/25.
//

import Foundation
import Combine
import SolanaPackage
import SolanaPackageUI

class AppInitializerViewModel: ObservableObject {
    private let appStore: AppStore
    private let navigationStore: AppNavigationStore
    private var cancellables = Set<AnyCancellable>()
    
    var exposedNavigationStore: AppNavigationStore {
        navigationStore
    }
    
    init(appStore: AppStore, navigationStore: AppNavigationStore) {
        self.appStore = appStore
        self.navigationStore = navigationStore
    }
    
    func initializeApp() {
        let publicKeyPublisher = appStore.fetchPresentablePublicKeys()
        let seedPublisher = appStore.fetchPresentableSeeds()
        
        Publishers.Zip(publicKeyPublisher, seedPublisher)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error loading data: \(error.localizedDescription)")
                        self.navigationStore.currentView = .onboarding(
                            self.createOnboardingView(with: [])
                        )
                    }
                },
                receiveValue: { [weak self] publicKeys, seeds in
                    guard let self = self else { return }
                    if publicKeys.isEmpty {
                        // Navigate to Onboarding
                        self.navigationStore.currentView = .onboarding(
                            self.createOnboardingView(with: seeds)
                        )
                    } else {
                        // Navigate to Wallet List
                        let firstPublicKey = publicKeys.first!.value
                        self.fetchWalletData(for: firstPublicKey, publicKeys: publicKeys)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    private func fetchWalletData(for publicKey: String, publicKeys: [PresentablePublicKey]) {
        appStore.fetchTransactions(for: publicKey)
            .combineLatest(appStore.fetchPresentableBalance(for: publicKey))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error loading transactions or balance: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] transactions, balance in
                    guard let self = self else { return }
                    self.navigationStore.currentView = .walletList(
                        self.createWalletListView(
                            with: publicKeys,
                            with: transactions,
                            balance: balance
                        )
                    )
                }
            )
            .store(in: &cancellables)
    }
    
    private func createWalletListView(
        with publicKeys: [PresentablePublicKey],
        with transactions: [PresentableTransaction],
        balance: PresentableBalance
    ) -> WalletListView {
        WalletListView(
            headerTitle: "Wallets",
            headerTitleTextColor: .primary,
            headerSubtitle: "Manage your wallets securely",
            headerSubtitleTextColor: .blue,
            errorMessage: "Cannot load wallets",
            errorViewButtonTitle: "Try again",
            loadingTitle: "Loading wallets",
            tryAgain: { self.initializeApp() },
            selection: { publicKey in
                self.navigationStore.currentView = .walletDetail(
                    self.createWalletDetailView(for: PresentablePublicKey(value: publicKey), with: balance, with: transactions)
                )
            },
            viewModel: .init(model: publicKeys, isLoading: publicKeys.isEmpty, errorMessage: "Cannot load wallets")
        )
    }
    
    private func createOnboardingView(with seed: [PresentableSeed]) -> OnboardingView {
        OnboardingView(
            headerTitle: "Welcome to Blue Giant Labs",
            headerTitleTextColor: .white,
            headerSubtitle: "Providing head-to-head asset comparisons to help users make informed choices in the volatile Solana market. Get ready to start unleashing your financial freedom!",
            headerSubtitleTextColor: .blue,
            backgroundImageName: "OnboardingBackground",
            logoImageName: "OnboardingAppLogo",
            bundle: "com.deniztutuncu.SolanaPackageUI",
            firstButtonTitle: "Create Wallet",
            firstButtonAction: {
                self.navigationStore.currentView = .exportSeed(
                    self.createExportSeedView(with: seed)
                )
            },
            secondButtonTitle: "Import Wallet"
        ) {
            self.navigationStore.currentView = .importSeed(
                self.createImportSeedView(with: [PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: ""),
                                                 PresentableSeed(value: "")])
            )
        }
    }
    
    private func createWalletDetailView(
        for publicKey: PresentablePublicKey,
        with balance: PresentableBalance,
        with transactions: [PresentableTransaction]
    ) -> WalletDetailView {
        let networkTitle = WalletPresenter.network
        let currencyTitle = WalletPresenter.currency
        
        return WalletDetailView(
            publicKey: publicKey.value,
            network: networkTitle,
            currency: currencyTitle,
            balanceLabelTitle: "Balance:",
            balanceLoadingTitle: "Loading balance...",
            balanceErrorMessage: "Cannot load balance",
            balanceErrorButtonTitle: "Try again",
            transactionListTitle: "Transactions",
            transactionListSubtitle: "Recent transactions",
            transactionLoadingTitle: "Loading transactions...",
            transactionErrorMessage: "Cannot load transactions",
            transactionErrorButtonTitle: "Try again",
            transactionSelection: { _ in },
            tryLoadBalance: { _ in },
            tryLoadTransactions: { },
            balanceViewModel: .init(model: balance, isLoading: false, errorMessage: nil),
            transactionListViewModel: .init(model: transactions, isLoading: transactions.isEmpty, errorMessage: "Cannot load transactions")
        )
    }
    
    private func createExportSeedView(with seed: [PresentableSeed]) -> ExportSeedView {
        ExportSeedView(
            headerTitle: "Seed Phrase",
            headerTitleTextColor: .primary,
            headerSubtitle: "The seed phrase is never stored on the device. You will only see it once, and it is only shown during setup. Please ensure that you keep your seed phrase physically secure.",
            headerSubtitleTextColor: .blue,
            buttonTitle: "Create new wallet",
            errorMessage: "",
            errorViewButtonTitle: "",
            loadingTitle: "",
            loadAgain: { },
            action: { },
            viewModel: .init(model: seed, isLoading: seed.isEmpty, errorMessage: "Cannot load seed")
        )
    }
    
    private func createImportSeedView(with seed: [PresentableSeed]) -> ImportSeedView {
        ImportSeedView(
            headerTitle: "Seed Phrase",
            headerTitleTextColor: .primary,
            headerSubtitle: "The seed phrase is never stored on the device. You will only see it once, and it is only shown during setup. Please ensure that you keep your seed phrase physically secure.",
            headerSubtitleTextColor: .blue,
            buttonTitle: "Import wallet",
            action: { },
            viewModel: .init(model: seed, isLoading: seed.isEmpty, errorMessage: "Cannot load seed")
        )
    }
}
