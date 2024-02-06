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

final class iOSSwiftUINavigationAdapter: SeedDelegate, PublicKeyDelegate {
    
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
    
    private func makeWalletListView() -> CombinedWalletListView {
        let headerTitle = WalletPresenter.title
        let headerSubtitle = WalletPresenter.subtitle
        let loadingTitle = "Downloading wallets"
        let errorMessage = "Cannot load wallets"
        let errorViewButtonTitle = "Try again"
        
        let publisher = PublicKeyUIAdapter.publicKeyComposedWith(publicKeyPublisher: publicKeyPublisher)
        publisher.load()
        
        return CombinedWalletListView(
            headerTitle: headerTitle,
            headerSubtitle: headerSubtitle,
            errorMessage: errorMessage,
            errorViewButtonTitle: errorViewButtonTitle,
            loadingTitle: loadingTitle,
            tryAgain: { publisher.load() },
            selection: { publicKey in },
            viewModel: .init(model: publisher.onResourceLoad ?? []),
            publickeyLoading: publisher.onLoadingState
        )
    }
    
    private func makeOnboardingView(seed: [Seed]) -> OnboardingView {
        let onboardingHeaderTitle = "Welcome to TREA"
        let onboardingHeaderSubtitle = "Create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana."
        let onboardingCreateWalletButtonTitle = "Create new wallet"
        let onboardingImportWalletButtonTitle = "Import wallet from seed"
        
        let headerTitle = SeedPresenter.title
        let headerSubtitle = SeedPresenter.subtitle
        
        let imageBundle = "CreationOptionsBackground"
        let bundleForImage = "com.deniztutuncu.SolanaPackageUI"
        
        let providedViewSubtitle = "The seed phrase is never stored on the device and will be wiped out after importing your wallet. Remember, the order of the seed phrase is crucial."
        let buttonTitle = "Create wallet"
        let providedViewButtonTitle = "Import wallet"
        let errorMessage = "Cannot load seed phrase"
        let errorViewButtonTitle = "Try again"
        let loadingTitle = "Loading seed phrase"

        let seedUIpublisher = SeedUIAdapter.seedComposedWith(seedPublisher: seedPublisher)
        seedUIpublisher.load()
        
        let publicKeyPublisher = PublicKeyUIAdapter.publicKeyComposedWith(publicKeyPublisher: publicKeyPublisher)
        publicKeyPublisher.load()
        
        let walletCreationView = WalletCreationView(
            headerTitle: headerTitle,
            headerSubtitle: headerSubtitle,
            buttonTitle: buttonTitle,
            errorMessage: errorMessage,
            errorViewButtonTitle: errorViewButtonTitle,
            loadingTitle: loadingTitle,
            loadAgain: { seedUIpublisher.load() },
            action: {},
            viewModel: .init(model: seedUIpublisher.onResourceLoad ?? [], handler: { _ in })
        )
        
        let providedSeedComposerView = ProvidedSeedComposerView(headerTitle: headerTitle,
                                                                headerSubtitle: providedViewSubtitle,
                                                                buttonTitle: providedViewButtonTitle,
                                                                action: { self.navigation.currentView = .walletList(self.makeWalletListView()) },
                                                                viewModel: .init(handler: { providedSeed in }))

        return OnboardingView(
            headerTitle: onboardingHeaderTitle,
            headerSubtitle: onboardingHeaderSubtitle, 
            imageBundle: imageBundle, bundle: bundleForImage,
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
