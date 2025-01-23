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
    
    init(appStore: AppStore, navigationStore: AppNavigationStore) {
        self.appStore = appStore
        self.navigationStore = navigationStore
        self.navigationCoordinator = NavigationCoordinator(navigationStore: navigationStore)
    }
    
    private let appStore: AppStore
    private let navigationCoordinator: NavigationCoordinator
    private let navigationStore: AppNavigationStore
    private var cancellables = Set<AnyCancellable>()

    var exposedNavigationStore: AppNavigationStore {
        navigationStore
    }

    func initializeApp() {
        let publicKeyPublisher = appStore.fetchPresentablePublicKeys()
        let seedPublisher = appStore.fetchPresentableSeeds()

        Publishers.Zip(publicKeyPublisher, seedPublisher)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("Error loading data: \(error.localizedDescription)")
                        self?.navigationCoordinator.navigateToOnboarding(with: [])
                    }
                },
                receiveValue: { [weak self] publicKeys, seeds in
                    guard let self = self else { return }
                    if publicKeys.isEmpty {
                        self.navigationCoordinator.navigateToOnboarding(with: seeds)
                    } else {
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
                    self.navigationCoordinator.navigateToWalletList(publicKeys: publicKeys, transactions: transactions, balance: balance)
                }
            )
            .store(in: &cancellables)
    }
}
