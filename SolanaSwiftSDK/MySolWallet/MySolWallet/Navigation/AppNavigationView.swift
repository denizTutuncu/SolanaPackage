//
//  AppNavigationView.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import SwiftUI
import SwiftUI

struct AppNavigationView: View {
    @ObservedObject var coordinator: NavigationCoordinator
    @ObservedObject var seedStore: SeedStorePublisher
    @ObservedObject var publicKeyStore: PublicKeyStorePublisher
    @ObservedObject var transactionStore: TransactionStorePublisher
    @ObservedObject var balanceStore: BalanceStorePublisher
    @ObservedObject var appStore: AppStore

    private let onboardingFactory: OnboardingViewFactory
    private let walletFactory: WalletViewFactory
    private let seedFactory: SeedViewFactory

    init(coordinator: NavigationCoordinator,
         seedStore: SeedStorePublisher,
         publicKeyStore: PublicKeyStorePublisher,
         transactionStore: TransactionStorePublisher,
         balanceStore: BalanceStorePublisher,
         appStore: AppStore) {
        self.coordinator = coordinator
        self.seedStore = seedStore
        self.publicKeyStore = publicKeyStore
        self.transactionStore = transactionStore
        self.balanceStore = balanceStore
        self.appStore = appStore
        self.onboardingFactory = OnboardingViewFactory(navigation: coordinator, seedStore: seedStore)
        self.walletFactory = WalletViewFactory(navigation: coordinator, publicKeyStore: publicKeyStore, transactionStore: transactionStore, balanceStore: balanceStore)
        self.seedFactory = SeedViewFactory(navigation: coordinator, seedStore: seedStore, appStore: appStore)
    }
    
    @ViewBuilder
    var body: some View {
        switch coordinator.currentRoute {
        case .onboarding:
            onboardingFactory.makeOnboardingView()
        case .walletList:
            walletFactory.makeWalletListView()
        case .exportSeed:
            seedFactory.makeExportSeedView()
        case .importSeed:
            seedFactory.makeImportSeedView()
        case .walletDetail:
            walletFactory.makeWalletDetailView()
        }
    }
}
