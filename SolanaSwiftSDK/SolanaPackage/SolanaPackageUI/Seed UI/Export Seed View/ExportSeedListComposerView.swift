//
//  ExportSeedListComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct ExportSeedListComposerView: View {
    let buttonTitle: String
    let errorMessage: String
    let errorViewButtonTitle: String
    let loadingTitle: String
    let errorAction: () -> Void
    let action: () -> Void
    
    @State var loading = true
    @Binding var viewModel: SeedListViewModel
    
    var body: some View {
        switch loading {
        case true:
            VStack {
                LoadingView(title: loadingTitle)
            }
        case false:
            switch viewModel.model.isEmpty {
            case true:
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: errorAction)
            case false:
                VStack {
                    ExportSeedListView(viewModel: viewModel)
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
    
    struct SeedUIComposerTestView: View {
        
        var body: some View {
            VStack {
                ExportSeedListComposerView(buttonTitle: "",
                                       errorMessage: "",
                                       errorViewButtonTitle: "",
                                       loadingTitle: "Loading seed phrase",
                                       errorAction: { },
                                       action: { },
                                       loading: true,
                                       viewModel: .constant(.init(model: [])))
                ExportSeedListComposerView(buttonTitle: "",
                                       errorMessage: "Cannot load seed phrase",
                                       errorViewButtonTitle: "Try again",
                                       loadingTitle: "Loading seed phrase",
                                       errorAction: { },
                                       action: { },
                                       loading: false,
                                       viewModel: .constant(.init()))
                
                ExportSeedListComposerView(buttonTitle: "Create wallet",
                                       errorMessage: "",
                                       errorViewButtonTitle: "",
                                       loadingTitle: "",
                                       errorAction: { },
                                       action: { },
                                       loading: false,
                                       viewModel: .constant(.init(model: [PresentableSeed(value: "seed"),
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
                                                                          PresentableSeed(value: "crypto")])))
                
            }
        }
    }
}
