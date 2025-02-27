//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI
import Combine

@main
struct MySolWalletApp: App {
    @StateObject private var appStore = AppStore()
    @StateObject private var navigationCoordinator = NavigationCoordinator()
    @StateObject private var seedStore = SeedStorePublisher()
    @StateObject private var publicKeyStore = PublicKeyStorePublisher()
    @StateObject private var transactionStore = TransactionStorePublisher()
    @StateObject private var balanceStore = BalanceStorePublisher()

    var body: some Scene {
        WindowGroup {
            AppNavigationView(
                coordinator: navigationCoordinator,
                seedStore: seedStore,
                publicKeyStore: publicKeyStore,
                transactionStore: transactionStore,
                balanceStore: balanceStore,
                appStore: appStore
            )
            .onAppear {
                seedStore.bind(to: appStore.fetchPresentableSeeds())
            }
        }
    }
}
