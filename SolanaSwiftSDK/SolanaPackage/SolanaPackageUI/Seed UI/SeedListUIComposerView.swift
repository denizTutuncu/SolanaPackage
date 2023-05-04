//
//  SeedUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct SeedListUIComposerView: View {
    let buttonTitle: String
    let errorMessage: String
    let errorViewButtonTitle: String
    let loadingTitle: String
    let errorAction: () -> Void
    let action: () -> Void
    
    @State var loading = true
    @Binding var viewModel: SeedViewModel
    
    var body: some View {
        switch loading {
        case true:
            VStack {
                LoadingView(title: loadingTitle)
                Spacer()
            }
        case false:
            switch viewModel.isModelEmpty {
            case true:
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: errorAction)
            case false:
                VStack {
                    SeedListView(viewModel: $viewModel)
                    RoundedButton(
                        title: buttonTitle,
                        isEnabled: viewModel.canSubmit,
                        action: action)
                }
            }
        }
    }
}

struct SeedUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SeedUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Seed Loading List Composer Test View")
        }
    }
}

struct SeedUIComposerTestView: View {
    
    var body: some View {
        VStack {
            SeedListUIComposerView(buttonTitle: "",
                                   errorMessage: "",
                                   errorViewButtonTitle: "",
                                   loadingTitle: "Loading seed phrase",
                                   errorAction: { },
                                   action: { },
                                   loading: true,
                                   viewModel: .constant(.init(model: [],
                                                              handler: { _ in })))
            SeedListUIComposerView(buttonTitle: "",
                                   errorMessage: "Cannot load seed phrase",
                                   errorViewButtonTitle: "Try again",
                                   loadingTitle: "Loading seed phrase",
                                   errorAction: { },
                                   action: { },
                                   loading: false,
                                   viewModel: .constant(.init(handler: { _ in })))
            
            SeedListUIComposerView(buttonTitle: "Create wallet",
                                   errorMessage: "",
                                   errorViewButtonTitle: "",
                                   loadingTitle: "",
                                   errorAction: { },
                                   action: { },
                                   loading: false,
                                   viewModel: .constant(.init(model: ["private",
                                                                      "digital",
                                                                      "coin",
                                                                      "seed",
                                                                      "key",
                                                                      "has",
                                                                      "very",
                                                                      "long",
                                                                      "secret",
                                                                      "phrase",
                                                                      "that",
                                                                      "will",
                                                                      "prevent",
                                                                      "animal",
                                                                      "weasel",
                                                                      "brain",
                                                                      "person",
                                                                      "like",
                                                                      "you",
                                                                      "obtain",
                                                                      "any",
                                                                      "large",
                                                                      "wealth"
                                                                     ],
                                                              handler: { _ in })))
            
        }
    }
}


