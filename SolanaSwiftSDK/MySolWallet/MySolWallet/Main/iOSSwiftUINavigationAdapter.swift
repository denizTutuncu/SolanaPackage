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
        
        let headerTitle = WalletPresenter.title
        let headerSubtitle = WalletPresenter.subtitle
        let loadingTitle = "Downloading wallets."
        let errorMessage = "Cannot load wallets"
        let errorViewButtonTitle = "Try again"
        
        let publisher = PublicKeyUIAdapter.publicKeyComposedWith(publicKeyPublisher: publicKeyPublisher)
        
        withAnimation {
            if !keys.isEmpty {
                navigation.currentView = .walletList(
                    WalletListUIComposerView(headerTitle: headerTitle,
                                             headerSubtitle: headerSubtitle,
                                             errorMessage: errorMessage,
                                             errorViewButtonTitle: errorViewButtonTitle,
                                             loadingTitle: loadingTitle,
                                             tryAgain: {  },
                                             selection: { _ in },
                                             viewModel: .init(model: keys),
                                             publickeyLoading: publisher.onLoadingState))
            }
        }
    }
    
    func didCompleteWith(seed: [String]) {
        
        let headerTitle = "Seed Phrase"
        let headerSubtitle = "The seed phrase is never stored on the device. You will only see it once, and it is only shown during setup. The order of the seed phrase is crucial, so ensure that you toggle each button corresponding to each phrase to maintain the correct order. Please ensure that you keep your seed phrase physically secure."
        let buttonTitle = "Create wallet"
        let errorMessage = "Cannot load seed phrase"
        let errorViewButtonTitle = "Try again"
        let loadingTitle = "Loading seed phrase"

        let creationHeaderTitle = "Welcome to Trea"
        let creationHeaderSubtitle = "TREA, Trusted Repository for Electronic Assets, to create your crypto wallet with top-tier security. This app is protected by industry-standard encryption, ensuring a secure connection with Solana."
        let firstCreationButtonTitle = "Create new wallet"
        let secondCreationButtonTitle = "Import wallet from seed"
        
//        let publisher = SeedUIAdapter.seedComposedWith(seedPublisher: seedPublisher)
        
        navigation.currentView = .creation(
            OnboardingView(headerTitle: creationHeaderTitle,
                               headerSubtitle: creationHeaderSubtitle,
                               firstButtonTitle: firstCreationButtonTitle,
                               firstButtonAction: {
                                   self.navigation.currentView = .seed(
                                    WalletCreationComposerView(headerTitle: headerTitle,
                                                               headerSubtitle: headerSubtitle,
                                                               buttonTitle: buttonTitle,
                                                               errorMessage: errorMessage,
                                                               errorViewButtonTitle: errorViewButtonTitle,
                                                               loadingTitle: loadingTitle,
                                                               loadAgain: { },
                                                               action: {  },
                                                               viewModel: .init(model: seed, handler: { _ in })))
                               },
                               secondButtonTitle: secondCreationButtonTitle,
                               secondButtonAction: {
                                   //Push import wallet screen?
                               }))
    }
}
