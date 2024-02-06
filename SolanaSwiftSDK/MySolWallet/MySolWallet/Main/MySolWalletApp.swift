//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage
import Combine

@main
struct MySolWalletApp: App {
    let appStore = MainAppStore()
    @StateObject var navigationStore = MainAppNavigationStore()

    var body: some Scene {
        WindowGroup {
            MainAppInitializer(appStore: appStore, navigationStore: navigationStore)
        }
    }
}

struct MainAppInitializer: View {
    let appStore: MainAppStore
    let navigationStore: MainAppNavigationStore

    var body: some View {
        MainAppNavigationView(store: navigationStore)
            .onAppear {
                initializeMainApp()
            }
    }

    private func initializeMainApp() {
        var cancellables: [AnyCancellable] = []

        let publicKeyPublisher = appStore.makeLocalPublicKeyPublisher()
        let seedPublisher = appStore.makeLocalSeedPublisher()

        let combinedPublisher = Publishers.CombineLatest(publicKeyPublisher, seedPublisher)

        combinedPublisher
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { (publicKeys, seeds) in
                let adapter = iOSSwiftUINavigationAdapter(
                    navigation: self.navigationStore,
                    publicKeyPublisher: Just(publicKeys).setFailureType(to: Error.self).eraseToAnyPublisher(),
                    seedPublisher: Just(seeds).setFailureType(to: Error.self).eraseToAnyPublisher()
                )

                self.appStore.mainApp = MainApp.start(
                    publickeys: publicKeys,
                    seed: seeds, 
                    pkDelegate: adapter,
                    sDelegate: adapter
                )
            })
            .store(in: &cancellables)
    }
}
