//
//  ImportSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

public struct ImportSeedView: View {
    
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
            ImportSeedListComposerView(
                buttonTitle: buttonTitle,
                errorMessage: errorMessage,
                errorViewButtonTitle: errorViewButtonTitle,
                loadingTitle: loadingTitle,
                errorAction: loadAgain,
                action: action,
//                loading: viewModel.isLoading,
                viewModel: viewModel
            )
            Spacer()
        }
    }
}

struct ProvidedSeedComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProvidedSeedComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet Creation Import Seed Test View")
        }
    }
    
    struct ProvidedSeedComposerTestView: View {
        @State var tapped = false
        
        var body: some View {
            VStack {
                ImportSeedView(headerTitle: "Seed Phrase",
                               headerTitleTextColor: .primary,
                               headerSubtitle: "The seed phrase is never stored on the device and will be wiped out after importing your wallet. Remember, the order of the seed phrase is crucial.",
                               headerSubtitleTextColor: .blue,
                               buttonTitle: "Import wallet",
                               errorMessage: "Cannot load seed phrase",
                               errorViewButtonTitle: "Try again",
                               loadingTitle: "Loading seed phrase",
                               loadAgain: { tapped.toggle() },
                               action: { tapped.toggle() },
                               viewModel: .init(model: [PresentableSeed(value: "seed"),
                                                        PresentableSeed(value: "phrase"),
                                                        PresentableSeed(value: "important"),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: ""),
                                                        PresentableSeed(value: "")]))
                
                Text("Import wallet tapped: \(tapped.description)")
            }
        }
    }
}

