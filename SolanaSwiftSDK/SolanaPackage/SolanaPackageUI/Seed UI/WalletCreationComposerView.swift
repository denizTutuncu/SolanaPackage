//
//  SeedListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

public struct WalletCreationComposerView: View {
    
    public init(headerTitle: String,
                headerSubtitle: String,
                toogleOFFTitle: String,
                toogleisONTitle: String,
                buttonTitle: String,
                errorMessage: String,
                downloadingTitle: String,
                action: @escaping () -> Void,
                handler: @escaping ([PresentableSeed]) -> Void,
                viewModel: SeedViewModel) {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.toogleOFFTitle = toogleOFFTitle
        self.toogleisONTitle = toogleisONTitle
        self.buttonTitle = buttonTitle
        self.errorMessage = errorMessage
        self.downloadingTitle = downloadingTitle
        self.action = action
        self.handler = handler
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerSubtitle: String
    private let toogleOFFTitle: String
    private let toogleisONTitle: String
    private let buttonTitle: String
    private let errorMessage: String
    private let downloadingTitle: String
    private let action: () -> Void
    private let handler: ([PresentableSeed]) -> Void
    
    @State private var viewModel: SeedViewModel
    @State private var allSeedPhraseSafe = false
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            
            SeedUIComposerView(errorMessage: errorMessage,
                               downloadingTitle: downloadingTitle,
                               tryAgain: action,
                               selection: handler,
                               seed: $viewModel.seed)
            
            ToogleView(isOFFTitle: toogleOFFTitle,
                       isONTitle: toogleisONTitle,
                       isOn: $allSeedPhraseSafe)
            
            RoundedButton(
                title: buttonTitle,
                isEnabled: allSeedPhraseSafe && viewModel.canSubmit,
                action: action
            )
        }
    }
}

struct WalletCreationComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletCreationComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet Creation Composer Test View")
        }
    }
    
    struct WalletCreationComposerTestView: View {
        @State var tapped = false
        
        var body: some View {
            VStack {
                WalletCreationComposerView(
                    headerTitle: "Seed Phrase",
                    headerSubtitle: "The seed phrase is never stored on the device. You will only see it once, and it is only shown during setup. The order of the seed phrase is crucial, so ensure that you toggle each button corresponding to each phrase to maintain the correct order. Please ensure that you keep your seed phrase physically secure.",
                    toogleOFFTitle: "Seed phrase is not safe yet.",
                    toogleisONTitle: "Seed phrase is safe now.",
                    buttonTitle: "Create wallet",
                    errorMessage: "Cannot connect to network.",
                    downloadingTitle: "Dowloading seed phrase",
                    action: { tapped.toggle() },
                    handler: { _ in },
                    viewModel: .init(seed: [
                        PresentableSeed(value: "private"),
                        PresentableSeed(value: "digital"),
                        PresentableSeed(value: "coin"),
                        PresentableSeed(value: "seed"),
                        PresentableSeed(value: "key"),
                        PresentableSeed(value: "has"),
                        PresentableSeed(value: "very"),
                        PresentableSeed(value: "long"),
                        PresentableSeed(value: "secret"),
                        PresentableSeed(value: "pass"),
                        PresentableSeed(value: "phrase"),
                        PresentableSeed(value: "that"),
                        PresentableSeed(value: "will"),
                        PresentableSeed(value: "prevent"),
                        PresentableSeed(value: "animal"),
                        PresentableSeed(value: "weasel"),
                        PresentableSeed(value: "brain"),
                        PresentableSeed(value: "person"),
                        PresentableSeed(value: "like"),
                        PresentableSeed(value: "you"),
                        PresentableSeed(value: "obtain"),
                        PresentableSeed(value: "any"),
                        PresentableSeed(value: "large"),
                        PresentableSeed(value: "wealth")],
                                     handler: { _ in }))
                
                Text("Create wallet tapped: \(tapped.description)")
            }
        }
    }
}


//I am currently working on a personal, open-source project called Solana Swift SDK. It contains 2 frameworks and an iOS app called MySolWallet. The project's purpose is to create an iOS native crypto wallet. The iOS app uses embedded frameworks, such as the SolanaPackage macOS Framework and the SolanaPackageUI iOS framework.
//
//The flow is as follows: when the app starts, it checks if any wallets have been created before. If there are, the app goes to a screen that represents the first wallet's details, includes its balance and transaction list.
//
//To achieve this, I thought about creating a Store that saves, updates, and receives wallets. At a core level, a wallet is a String type and mostly called Public Key in the core module, that will convert into a Wallet type later on.
//
//Currently, I am not confident about my flow implementation, but that is what I have, and I would love to hear your thoughts.
//
//If there are no wallets AKA public keys in the store, another loader loads a seed and then passes it to get the public and private keys. The system must keep these 2 keys into two different stores safely and loads the balance and transaction via network calls with the public key. Seed is an array string with 24 items and comes from a hardcoded store that can load 2048 English words. Seed loader accesses the store and applies some validations to secure the seed before passing it into whatever can create a Solana wallet. This part involves cryptography, which I don't have to worry about because it's a detail.
//
//The detail will probably be a CocoaPod on the iOS app module, but isn't that the whole point? I will give it a seed, and I don't care how it generates a wallet, but a wallet means a public and private key.
//
//A public key is an identifier, and we pass this data into network calls, such as asking for a balance for a specific account which is the public key. Any action from the account requires the private key via signing its transaction. Private keys are super important, whereas public keys are not. The system can save, hold, and receive public keys as [Strings] from its store.
//
//The system has different specs for private keys. It is a one-to-one relationship within the use case, via Keychain. A private key store can only return a private key for a specific asked public key. The system also applies some validations here too. Basically, its loader returns a specific private key if the asker is authorized via keychain for a specific asked public key. Deletion works similarly.
//
//Unfortunately, I am having issues organizing and composing pieces on an iOS app level. I can't connect some concepts and it feels like I can't put a puzzle together. Yikes! The current macOS framework in the codebase is tested around 85%, but the iOS framework, such as the SolanaPackageUI framework, is at 0 because there are no snapshot tests. Is it possible to see your approach to snapshot testing on SwiftUI? I'm also not sure if I am having extra, unnecessary exposure on my UI models, so I would also love to take a look there too.
