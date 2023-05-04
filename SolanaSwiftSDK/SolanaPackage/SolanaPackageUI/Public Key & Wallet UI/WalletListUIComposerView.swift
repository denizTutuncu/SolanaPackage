//
//  WalletListUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/29/23.
//

import SwiftUI

public struct WalletListUIComposerView: View {
    
    public init(headerTitle: String,
                headerSubtitle: String,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                tryAgain: @escaping () -> Void,
                selection: @escaping (String) -> Void,
                viewModel: PublicKeyViewModel,
                publickeyLoading: Bool
    ) {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.errorMessage = errorMessage
        self.errorViewButtonTitle =  errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.tryAgain = tryAgain
        self.selection = selection
        self._viewModel = State(initialValue: viewModel)
        self._publickeyLoading = State(initialValue: publickeyLoading)
    }
    
    private let headerTitle: String
    private let headerSubtitle: String
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let tryAgain: () -> Void
    
    private let selection: (String) -> Void
    
    @State private var viewModel: PublicKeyViewModel
    @State private var publickeyLoading: Bool

    public var body: some View {
        VStack {
            HeaderView(title: headerTitle, subtitle: headerSubtitle)
            
            if publickeyLoading {
                LoadingView(title: loadingTitle)
                Spacer()
            } else {
                
                if viewModel.isModelEmpty {
                    ErrorView(message: errorMessage, buttonTitle: errorViewButtonTitle, onHide: {
                        publickeyLoading = true ; tryAgain()
                    })
                } else {
                    WalletListView(viewModel: viewModel, selection: selection)
                }
            }
        }
    }
}

struct WalletListUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletListUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List UI Composer Test View")
        }
    }
}

struct WalletListUIComposerTestView: View {
    @State var selection: String = "none"
    
    var body: some View {
        VStack {
            WalletListUIComposerView(headerTitle: "Wallets",
                                     headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                                     errorMessage: "Cannot load wallets",
                                     errorViewButtonTitle: "Try again",
                                     loadingTitle: "Loading wallets",
                                     tryAgain: { },
                                     selection: { _ in },
                                     viewModel: .init(),
                                     publickeyLoading: true)
            
            WalletListUIComposerView(headerTitle: "Wallets",
                                     headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                                     errorMessage: "Cannot load wallets",
                                     errorViewButtonTitle: "Try again",
                                     loadingTitle: "Loading wallets",
                                     tryAgain: { },
                                     selection: { _ in },
                                     viewModel: .init(model: []),
                                     publickeyLoading: false)
            
            
            WalletListUIComposerView(headerTitle: "Wallets",
                                     headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                                     errorMessage: "",
                                     errorViewButtonTitle: "",
                                     loadingTitle: "",
                                     tryAgain: { },
                                     selection: { selection = $0 },
                                     viewModel: .init(model: [
                                        "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                        "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                        "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA"
                                     ]),
                                     publickeyLoading: false)
            
//            Text("Last selection: " + selection).padding()
            
        }
    }
}
