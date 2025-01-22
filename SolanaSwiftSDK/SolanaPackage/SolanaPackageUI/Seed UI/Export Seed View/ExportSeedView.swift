//
//  ExportSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

public struct ExportSeedView: View {
    
    public init(headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                buttonTitle: String,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                action: @escaping () -> Void,
                viewModel: SeedListViewModel)
    {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.buttonTitle = buttonTitle
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.loadAgain = loadAgain
        self.action = action
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let buttonTitle: String
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let loadAgain: () -> Void
    private let action: () -> Void
    
    @State private var viewModel: SeedListViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle,
                       titleTextColor: headerTitleTextColor,
                       subtitle: headerSubtitle,
                       subtitleTextColor: headerSubtitleTextColor)
            
            ExportSeedListComposerView(buttonTitle: buttonTitle,
                                       errorMessage: errorMessage,
                                       errorViewButtonTitle: errorViewButtonTitle,
                                       loadingTitle: loadingTitle,
                                       errorAction: loadAgain,
                                       action: action,
                                       loading: viewModel.model.isEmpty,
                                       viewModel: viewModel)
        }
    }
}

struct WalletCreationComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletCreationComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet Creation From Export Seed Test View")
        }
    }
    
    struct WalletCreationComposerTestView: View {
        @State var tapped = false
        
        var body: some View {
            VStack {
                ExportSeedView(
                    headerTitle: "Seed Phrase",
                    headerTitleTextColor: .primary,
                    headerSubtitle: "The seed phrase is never stored on the device. You will only see it once, and it is only shown during setup. The order of the seed phrase is crucial, so ensure that you toggle each button corresponding to each phrase to maintain the correct order. Please ensure that you keep your seed phrase physically secure.",
                    headerSubtitleTextColor: .blue,
                    buttonTitle: "Create wallet",
                    errorMessage: "Cannot load seed phrase",
                    errorViewButtonTitle: "Try again",
                    loadingTitle: "Loading seed phrase",
                    loadAgain: { tapped.toggle() },
                    action: { tapped.toggle() },
                    viewModel: .init(model:  [PresentableSeed(value: "seed"),
                                              PresentableSeed(value: "phrase"),
                                              PresentableSeed(value: "important"),
                                              PresentableSeed(value: "who"),
                                              PresentableSeed(value: "has"),
                                              PresentableSeed(value: "seed"),
                                              PresentableSeed(value: "has"),
                                              PresentableSeed(value: "access"),
                                              PresentableSeed(value: "wallet"),
                                              PresentableSeed(value: "secure"),
                                              PresentableSeed(value: "crucial"),
                                              PresentableSeed(value: "ownership"),
                                              PresentableSeed(value: "must"),
                                              PresentableSeed(value: "keep"),
                                              PresentableSeed(value: "offline"),
                                              PresentableSeed(value: "physical"),
                                              PresentableSeed(value: "share"),
                                              PresentableSeed(value: "with"),
                                              PresentableSeed(value: "love"),
                                              PresentableSeed(value: "ones"),
                                              PresentableSeed(value: "teach"),
                                              PresentableSeed(value: "them"),
                                              PresentableSeed(value: "early"),
                                              PresentableSeed(value: "crypto")]))
                
                Text("Create wallet tapped: \(tapped.description)")
            }
        }
    }
}
