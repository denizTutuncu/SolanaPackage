//
//  SeedViewFactory.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/26/25.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI

final class SeedViewFactory {
    private let navigation: NavigationCoordinator
    private let seedStore: SeedStorePublisher
    private let appStore: AppStore
    
    init(navigation: NavigationCoordinator, seedStore: SeedStorePublisher, appStore: AppStore) {
        self.navigation = navigation
        self.seedStore = seedStore
        self.appStore = appStore
    }
    
    func makeExportSeedView() -> ExportSeedView {
        let seedCount = seedStore.seedViewModelPublisher.resourceViewModel?.count ?? 0
        print("📌 Creating ExportSeedView with \(seedCount) seeds") // ✅ Debugging
        
        return ExportSeedView(
            viewModel: ExportSeedViewModel(
                model: seedStore.seedViewModelPublisher.resourceViewModel ?? [],
                isLoading: seedStore.seedViewModelPublisher.isLoading
            ),
            headerTitle: SeedPresenter.exportSeedViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: SeedPresenter.exportSeedViewSubtitle,
            headerSubtitleTextColor: .blue,
            buttonTitle: SeedPresenter.exportSeedViewButtonTitle,
            errorMessage: SeedPresenter.exportSeedViewErrorMessage,
            errorViewButtonTitle: SeedPresenter.exportSeedViewErrorButtonTitle,
            loadingTitle: SeedPresenter.exportSeedViewLoadingTitle,
            loadAgain: {
                print("🔄 Reloading seed...")
                self.seedStore.bind(to: self.appStore.fetchPresentableSeeds()) // ✅ Ensure re-fetching works
            },
            action: {
                print("🔑 Creating keys from seed...")
                self.navigation.navigate(to: .walletDetail)
            },
            backButtonTitle: "Back",
            backAction: { self.navigation.navigate(to: .onboarding) }
        )
    }
    
    
    func makeImportSeedView() -> ImportSeedView {
        ImportSeedView(
            viewModel: ImportSeedViewModel(
                model: [PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                        PresentableSeed(),
                       ],
                isLoading: seedStore.seedViewModelPublisher.isLoading
            ),
            headerTitle: SeedPresenter.importSeedViewTitle,
            headerTitleTextColor: .primary,
            headerSubtitle: SeedPresenter.importSeedViewSubtitle,
            headerSubtitleTextColor: .blue,
            buttonTitle: SeedPresenter.importSeedViewButtonTitle,
            errorMessage: SeedPresenter.importSeedViewErrorMessage,
            errorViewButtonTitle: SeedPresenter.importSeedViewErrorButtonTitle,
            loadingTitle: SeedPresenter.importSeedViewLoadingTitle,
            loadAgain: {
                print("Reloading import seed...")
                // TODO: Implement reload logic
            },
            action: {
                self.navigation.navigate(to: .walletDetail)
            },
            backButtonTitle: "Back",
            backAction: { self.navigation.navigate(to: .onboarding) }
        )
    }
}
