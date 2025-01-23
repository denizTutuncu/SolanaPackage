//
//  NavigationCoordinator.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/22/25.
//

import Foundation
import SolanaPackageUI

class NavigationCoordinator {
    private let navigationStore: AppNavigationStore

    init(navigationStore: AppNavigationStore) {
        self.navigationStore = navigationStore
    }

    func navigateToOnboarding(with seeds: [PresentableSeed]) {
        navigationStore.currentView = .onboarding(ViewFactory.makeOnboardingView(seeds: seeds, coordinator: self))
    }

    func navigateToWalletList(publicKeys: [PresentablePublicKey], transactions: [PresentableTransaction], balance: PresentableBalance) {
        navigationStore.currentView = .walletList(
            ViewFactory.makeWalletListView(
                publicKeys: publicKeys,
                transactions: transactions,
                balance: balance,
                coordinator: self
            )
        )
    }

    func navigateToWalletDetail(publicKey: PresentablePublicKey, transactions: [PresentableTransaction], balance: PresentableBalance) {
        navigationStore.currentView = .walletDetail(
            ViewFactory.makeWalletDetailView(publicKey: publicKey, transactions: transactions, balance: balance, coordinator: self)
        )
    }

    func navigateToExportSeed(seeds: [PresentableSeed]) {
        navigationStore.currentView = .exportSeed(
            ViewFactory.makeExportSeedView(seeds: seeds, coordinator: self)
        )
    }

    func navigateToImportSeed(seeds: [PresentableSeed]) {
        navigationStore.currentView = .importSeed(
            ViewFactory.makeImportSeedView(seeds: seeds, coordinator: self)
        )
    }
}
