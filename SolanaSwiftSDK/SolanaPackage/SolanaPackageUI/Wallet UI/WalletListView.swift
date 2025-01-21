//
//  WalletListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/29/23.
//

import SwiftUI

public struct WalletListView: View {
    
    public init(headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                tryAgain: @escaping () -> Void,
                selection: @escaping (String) -> Void,
                viewModel: PresentablePublicKeyViewModel
    ) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.errorMessage = errorMessage
        self.errorViewButtonTitle =  errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.tryAgain = tryAgain
        self.selection = selection
        self._viewModel = State(initialValue: viewModel)
    }
    
    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let tryAgain: () -> Void
    private let selection: (String) -> Void
    
    @State private var viewModel: PresentablePublicKeyViewModel
    
    public var body: some View {
        VStack {
            HeaderView(
                title: headerTitle,
                titleTextColor: headerTitleTextColor,
                subtitle: headerSubtitle,
                subtitleTextColor: headerSubtitleTextColor
            )
            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
                Spacer()
            } else if ((viewModel.errorMessage) != nil) {
                ErrorView(
                    message: errorMessage,
                    buttonTitle: errorViewButtonTitle,
                    onHide: { tryAgain() }
                )
            } else {
                PublicKeyListView(viewModel: viewModel, selection: selection)
            }
        }
    }
}

struct WalletListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Combined Wallet List Test View")
        }
    }
}

struct WalletListTestView: View {
    @State var selection: String = "none"
    
    var body: some View {
        VStack {
            WalletListView(
                headerTitle: "Wallets",
                headerTitleTextColor: .primary,
                headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                headerSubtitleTextColor: .blue,
                errorMessage: "Cannot load wallets",
                errorViewButtonTitle: "Try again",
                loadingTitle: "Loading wallets",
                tryAgain: { },
                selection: { _ in },
                viewModel: .init())
            
            WalletListView(headerTitle: "Wallets",
                           headerTitleTextColor: .primary,
                           headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                           headerSubtitleTextColor: .blue,
                           errorMessage: "Cannot load wallets",
                           errorViewButtonTitle: "Try again",
                           loadingTitle: "Loading wallets",
                           tryAgain: { },
                           selection: { _ in },
                           viewModel: .init(model: [],
                                            isLoading: false,
                                            errorMessage: "Cannot load wallets"))
            
            
            WalletListView(headerTitle: "Wallets",
                           headerTitleTextColor: .primary,
                           headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your keys and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                           headerSubtitleTextColor: .blue,
                           errorMessage: "",
                           errorViewButtonTitle: "",
                           loadingTitle: "",
                           tryAgain: { },
                           selection: { selection = $0 },
                           viewModel: .init(model: [
                            PresentablePublicKey(value: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump"),
                            PresentablePublicKey(value: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD"),
                            PresentablePublicKey(value: "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA"),
                           ],
                                            isLoading: false,
                                            errorMessage: nil))
            
            //            Text("Last selection: " + selection).padding()
            
        }
    }
}
