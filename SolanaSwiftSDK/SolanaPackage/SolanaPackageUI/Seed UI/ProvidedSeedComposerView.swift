//
//  ProvidedSeedComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

public struct ProvidedSeedComposerView: View {
    
    public init(headerTitle: String,
                headerSubtitle: String,
                buttonTitle: String,
                action: @escaping () -> Void,
                viewModel: SeedViewModel)
    {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.buttonTitle = buttonTitle
        self.action = action
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerSubtitle: String
    private let buttonTitle: String
    private let action: () -> Void
    
    @State private var viewModel: SeedViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            ProvidedSeedListView(viewModel: viewModel)
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
                .previewDisplayName("Provided Seed Composer Test View")
        }
    }
    
    struct ProvidedSeedComposerTestView: View {
        @State var tapped = false
        
        var body: some View {
            VStack {
                ProvidedSeedComposerView(headerTitle: "Seed Phrase",
                                         headerSubtitle: "The seed phrase is never stored on the device and will be wiped out after importing your wallet. Remember, the order of the seed phrase is crucial.",
                                         buttonTitle: "Import wallet",
                                         action: { tapped.toggle() },
                                         viewModel: .init(model: ["seed",
                                                                  "phrase",
                                                                  "important",
                                                                  "who",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  "",
                                                                  ""], handler: { _ in }))
                
                Text("Import wallet tapped: \(tapped.description)")
            }
        }
    }
}

