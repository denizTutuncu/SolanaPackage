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
        let seedModel = seedStore.seedViewModelPublisher.resourceViewModel ?? []
        
        print("📌 Creating ExportSeedView with \(seedModel.count) seeds") // ✅ Debugging
        print("📌 Creating ExportSeedView with \(seedModel.map { $0.value }) seeds") // ✅ Debugging


        return ExportSeedView(
            viewModel: ExportSeedViewModel(
                model: seedModel,
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
                self.seedStore.bind(to: self.appStore.fetchPresentableSeeds())
            },
            action: {
                print("🔑 Creating keys from seed...")
                let seedValues = seedModel.map { $0.value } // ✅ Store and pass the same seed
                Task {
                    await self.appStore.generateWallet(from: seedValues)
                }
                self.navigation.navigate(to: .walletDetail)
            },
            actionButtonBackgroundColor: .blue,
            backButtonTitle: "Back",
            backAction: { self.navigation.navigate(to: .onboarding) },
            backButtonBackgroundColor: .gray
        )
    }
    
    func makeImportSeedView() -> ImportSeedView {
        let vm = ImportSeedViewModel(
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
        )
        
        return ImportSeedView(
            viewModel: vm,
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
                Task {
                    await self.appStore.generateWallet(from: vm.model.map { $0.value})
                }
                self.navigation.navigate(to: .walletDetail)
            },
            actionButtonBackgroundColor: .blue,
            backButtonTitle: "Back",
            backAction: { self.navigation.navigate(to: .onboarding) },
            backButtonBackgroundColor: .gray
        )
    }
}
