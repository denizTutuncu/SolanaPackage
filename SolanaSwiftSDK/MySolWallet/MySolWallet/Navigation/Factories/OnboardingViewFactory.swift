//
//  OnboardingViewFactory.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/26/25.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI

final class OnboardingViewFactory {
    private let navigation: NavigationCoordinator
    private let seedStore: SeedStorePublisher

    init(navigation: NavigationCoordinator, seedStore: SeedStorePublisher) {
        self.navigation = navigation
        self.seedStore = seedStore
    }
    
    func makeOnboardingView() -> WalletSetupView {
        WalletSetupView(
            headerTitle: "Welcome to Blue Giant Labs",
            headerTitleTextColor: .white,
            headerSubtitle: "Providing head-to-head Solana asset comparisons to help users make informed choices in the volatile crypto market.",
            headerSubtitleTextColor: .blue,
            backgroundImageName: "OnboardingBackground",
            logoImageName: "OnboardingAppLogo",
            bundle: "com.deniztutuncu.SolanaPackageUI",
            firstButtonTitle: "Create Wallet",
            firstButtonAction: { self.navigation.navigate(to: .exportSeed) },
            secondButtonTitle: "Import Wallet",
            secondButtonAction: { self.navigation.navigate(to: .importSeed) }
        )
    }
}
