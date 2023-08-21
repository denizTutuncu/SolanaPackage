//
//  iOSSwiftUINavigationAdapter.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/16/23.
//

import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

final class iOSSwiftUINavigationAdapter: PublicKeyDelegate {
    
    init(navigation: MainAppNavigationStore,
         publicKeyPublisher: AnyPublisher<[PublicKey], Error>,
         seedPublisher: AnyPublisher<[Seed], Error>
    ) {
        self.navigation = navigation
        self.publicKeyPublisher = publicKeyPublisher
        self.seedPublisher = seedPublisher
    }
    
    typealias PublicKey = String
    typealias Seed = String
    
    private let navigation: MainAppNavigationStore
    private let publicKeyPublisher: AnyPublisher<[PublicKey], Error>
    private let seedPublisher: AnyPublisher<[Seed], Error>
    
    func didCompleteWith(keys: [PublicKey]) {
        if !keys.isEmpty {
            let walletListView = makeWalletListView()
            withAnimation {
                navigation.currentView = .walletList(walletListView)
            }
        }
    }
    
    func didCompleteWith(seed: [Seed]) {
        if !seed.isEmpty {
            let onboardingView = makeOnboardingView(seed: seed)
            withAnimation {
                navigation.currentView = .creation(onboardingView)
            }
        }
    }
    
    private func makeWalletListView() -> WalletListUIComposerView {
        let headerTitle = WalletPresenter.title
        let headerSubtitle = WalletPresenter.subtitle
        let loadingTitle = "Downloading wallets."
        let errorMessage = "Cannot load wallets"
        let errorViewButtonTitle = "Try again"
        
        let publisher = PublicKeyUIAdapter.publicKeyComposedWith(publicKeyPublisher: publicKeyPublisher)
        publisher.load()
        
        return WalletListUIComposerView(
            headerTitle: headerTitle,
            headerSubtitle: headerSubtitle,
            errorMessage: errorMessage,
            errorViewButtonTitle: errorViewButtonTitle,
            loadingTitle: loadingTitle,
            tryAgain: { publisher.load() },
            selection: { _ in },
            viewModel: .init(model: publisher.onResourceLoad ?? []),
            publickeyLoading: publisher.onLoadingState
        )
    }
    
    private func makeOnboardingView(seed: [Seed]) -> OnboardingView {
        let onboardingHeaderTitle = "Welcome to Trea"
        let onboardingHeaderSubtitle = "TREA, Trusted Repository for Electronic Assets, to create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana."
        let onboardingCreateWalletButtonTitle = "Create new wallet"
        let onboardingImportWalletButtonTitle = "Import wallet from seed"
        
        let headerTitle = SeedPresenter.title
        let headerSubtitle = SeedPresenter.subtitle
        let providedViewSubtitle = "The seed phrase is never stored on the device and will be wiped out after importing your wallet. Remember, the order of the seed phrase is crucial."
        let buttonTitle = "Create wallet"
        let providedViewButtonTitle = "Import wallet"
        let errorMessage = "Cannot load seed phrase"
        let errorViewButtonTitle = "Try again"
        let loadingTitle = "Loading seed phrase"
        
        let publisher = SeedUIAdapter.seedComposedWith(seedPublisher: seedPublisher)
        publisher.load()
        
        let walletCreationView = WalletCreationComposerView(
            headerTitle: headerTitle,
            headerSubtitle: headerSubtitle,
            buttonTitle: buttonTitle,
            errorMessage: errorMessage,
            errorViewButtonTitle: errorViewButtonTitle,
            loadingTitle: loadingTitle,
            loadAgain: { publisher.load() },
            action: {},
            viewModel: .init(model: seed, handler: { _ in })
        )
        
        let providedSeedComposerView = ProvidedSeedComposerView(headerTitle: headerTitle,
                                                                headerSubtitle: providedViewSubtitle,
                                                                buttonTitle: providedViewButtonTitle,
                                                                action: {  },
                                                                viewModel: .init(model: [],
                                                                                 handler: { _ in }))
        
        
        return OnboardingView(
            headerTitle: onboardingHeaderTitle,
            headerSubtitle: onboardingHeaderSubtitle,
            firstButtonTitle: onboardingCreateWalletButtonTitle,
            firstButtonAction: {
                self.navigation.currentView = .seed(walletCreationView)
            },
            secondButtonTitle: onboardingImportWalletButtonTitle,
            secondButtonAction: {
                self.navigation.currentView = .userSeed(providedSeedComposerView)
            }
        )
    }
}
