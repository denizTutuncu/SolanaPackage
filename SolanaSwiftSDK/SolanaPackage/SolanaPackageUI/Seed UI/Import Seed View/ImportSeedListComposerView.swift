//
//  ImportSeedListComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/21/25.
//

// ImportSeedListComposerView.swift
import SwiftUI

struct ImportSeedListComposerView: View {
    let buttonTitle: String
    let errorMessage: String
    let errorViewButtonTitle: String
    let loadingTitle: String
    let errorAction: () -> Void
    let action: () -> Void
    
//    @State var loading = true
    @ObservedObject var viewModel: SeedListViewModel
    
    var body: some View {
        if viewModel.isLoading {
            VStack {
                LoadingView(title: loadingTitle)
            }
        } else if viewModel.model.isEmpty {
            ErrorView(message: errorMessage,
                      buttonTitle: errorViewButtonTitle,
                      onHide: errorAction)
        } else {
            VStack {
                ImportSeedListView(viewModel: viewModel)
                RoundedButton(
                    title: buttonTitle,
                    isEnabled: viewModel.canSubmit,
                    action: action
                )
            }
        }
    }
}

struct ImportSeedListComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImportSeedListComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Import Seed List Composer Test View")
        }
    }
    
    struct ImportSeedListComposerTestView: View {
        
        var body: some View {
            VStack {
                ImportSeedListComposerView(buttonTitle: "",
                                           errorMessage: "",
                                           errorViewButtonTitle: "",
                                           loadingTitle: "Loading seed phrase",
                                           errorAction: { },
                                           action: { },
//                                           loading: true,
                                           viewModel: .init(model: [], isLoading: true))
                ImportSeedListComposerView(buttonTitle: "",
                                           errorMessage: "Cannot load seed phrase",
                                           errorViewButtonTitle: "Try again",
                                           loadingTitle: "Loading seed phrase",
                                           errorAction: { },
                                           action: { },
//                                           loading: false,
                                           viewModel: .init())
                
                ImportSeedListComposerView(buttonTitle: "Create wallet",
                                           errorMessage: "",
                                           errorViewButtonTitle: "",
                                           loadingTitle: "",
                                           errorAction: { },
                                           action: { },
//                                           loading: false,
                                           viewModel: .init(model: [PresentableSeed(value: "seed"),
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
                                                                    PresentableSeed(value: "wkeepho"),
                                                                    PresentableSeed(value: "offline"),
                                                                    PresentableSeed(value: "physical"),
                                                                    PresentableSeed(value: "share"),
                                                                    PresentableSeed(value: "with"),
                                                                    PresentableSeed(value: "love"),
                                                                    PresentableSeed(value: "ones"),
                                                                    PresentableSeed(value: "teach"),
                                                                    PresentableSeed(value: "them"),
                                                                    PresentableSeed(value: "early"),
                                                                    PresentableSeed(value: "crypto"),
                                                                   ],
                                                            isLoading: false))
                
            }
        }
    }
}
