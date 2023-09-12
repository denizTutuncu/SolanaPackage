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
                buttonTitle: String,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                action: @escaping () -> Void,
                viewModel: SeedViewModel)
    {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.buttonTitle = buttonTitle
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.loadAgain = loadAgain
        self.action = action
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerSubtitle: String
    private let buttonTitle: String
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let loadAgain: () -> Void
    private let action: () -> Void
    
    @State private var viewModel: SeedViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            
            SeedListUIComposerView(buttonTitle: buttonTitle,
                                   errorMessage: errorMessage,
                                   errorViewButtonTitle: errorViewButtonTitle,
                                   loadingTitle: loadingTitle,
                                   errorAction: loadAgain,
                                   action: action,
                                   loading: viewModel.isModelEmpty,
                                   viewModel: $viewModel)
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
                    buttonTitle: "Create wallet",
                    errorMessage: "Cannot load seed phrase",
                    errorViewButtonTitle: "Try again",
                    loadingTitle: "Loading seed phrase",
                    loadAgain: { tapped.toggle() },
                    action: { tapped.toggle() },
                    viewModel: .init(model:  ["seed",
                                              "phrase",
                                              "important",
                                              "who",
                                              "has",
                                              "seed",
                                              "has",
                                              "access",
                                              "wallet",
                                              "secure",
                                              "crucial",
                                              "ownership",
                                              "must",
                                              "keep",
                                              "offline",
                                              "physical",
                                              "share",
                                              "with",
                                              "love",
                                              "ones",
                                              "teach",
                                              "them",
                                              "early",
                                              "crypto"],
                                     handler: { _ in }))
                
                                Text("Create wallet tapped: \(tapped.description)")
            }
        }
    }
}
