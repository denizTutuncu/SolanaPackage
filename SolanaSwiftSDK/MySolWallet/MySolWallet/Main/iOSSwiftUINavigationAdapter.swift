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

final class iOSSwiftUINavigationAdapter: PublicKeyDelegate, SeedDelegate {
    
    typealias PublicKey = String
    typealias Seed  = String
    
    private let navigation: BankNavigationStore
    private let publicKeyPublisher: AnyPublisher<[PublicKey], Error>
    private let seedPublisher: AnyPublisher<[Seed], Error>
    private let createWallet: ([Seed]) -> Void
    private let selectPublicKey: (PublicKey) -> Void
    
    init(navigation: BankNavigationStore,
         publicKeyPublisher: AnyPublisher<[PublicKey], Error>,
         seedPublisher: AnyPublisher<[Seed], Error>,
         createWallet: @escaping ([Seed]) -> Void,
         selectPublicKey: @escaping (PublicKey) -> Void)
    {
        self.navigation = navigation
        self.publicKeyPublisher = publicKeyPublisher
        self.seedPublisher = seedPublisher
        self.createWallet = createWallet
        self.selectPublicKey = selectPublicKey
    }
    
    func didComplete(completion: @escaping ([PublicKey]) -> Void) {
        let headerTitle = "Wallets"
        let headerSubtitle = "Keychain is a secure storage area on your device that uses encryption to keep your passwords and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access."
        let loadingTitle = "Downloading wallets"
        
        let publisher = PublicKeyUIAdapter.publicKeyComposedWith(publicKeyPublisher: publicKeyPublisher)
        
        withAnimation {
            navigation.currentView = .wallet(
                WalletListUIComposerView(headerTitle: headerTitle,
                                         headerSubtitle: headerSubtitle,
                                         loadingTitle: loadingTitle,
                                         viewModel: .init(publicKeys: publisher.onResourceLoad ?? [],
                                                          handler: { [weak self] in self?.selectPublicKey($0.id) }),
                                         selection: { [weak self] in self?.selectPublicKey($0.id) })
            )
            
        }
    }
    
    func didComplete(completion: [Seed]) {
        let headerTitle = SeedPresenter.title
        let headerSubtitle = SeedPresenter.subtitle
        let toogleOFFTitle = "Seed phrase is not safe yet."
        let toogleisONTitle = "Seed phrase is safe now."
        let buttonTitle = "Create wallet"
        let errorMessage = "Cannot connect to network."
        let downloadingTitle = "Downloading seed phrase."
        
        let publisher = SeedUIAdapter.seedComposedWith(seedPublisher: seedPublisher)
        
        withAnimation {
            navigation.currentView = .seed(
                WalletCreationComposerView(headerTitle: headerTitle,
                                           headerSubtitle: headerSubtitle,
                                           toogleOFFTitle: toogleOFFTitle,
                                           toogleisONTitle: toogleisONTitle,
                                           buttonTitle: buttonTitle,
                                           errorMessage: errorMessage,
                                           downloadingTitle: downloadingTitle,
                                           action: { },
                                           handler: { [weak self] in self?.createWallet($0.map{ $0.value })},
                                           viewModel: .init(seed: publisher.onResourceLoad ?? [],
                                                            handler: { [weak self] in self?.createWallet($0.map{ $0.value }) }))
            )
        }
    }
    
}
