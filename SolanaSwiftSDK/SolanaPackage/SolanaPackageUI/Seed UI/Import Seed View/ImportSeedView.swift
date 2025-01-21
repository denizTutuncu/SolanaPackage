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
                action: @escaping () -> Void,
                viewModel: SeedListViewModel)
    {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.buttonTitle = buttonTitle
        self.action = action
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let buttonTitle: String
    private let action: () -> Void
    
    @State private var viewModel: SeedListViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle,
                       titleTextColor: headerTitleTextColor,
                       subtitle: headerSubtitle,
                       subtitleTextColor: headerSubtitleTextColor)
            ImportSeedListView(viewModel: viewModel)
            RoundedButton(
                title: buttonTitle,
                isEnabled: viewModel.canSubmit,
                action: action)
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

