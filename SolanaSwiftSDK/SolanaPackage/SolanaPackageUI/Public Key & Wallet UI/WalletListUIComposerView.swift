//
//  WalletListUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/21/23.
//

import SwiftUI

public struct WalletListUIComposerView: View {
    
    public init(headerTitle: String,
                headerSubtitle: String,
                loadingTitle: String,
                viewModel: PublicKeyViewModel,
                selection: @escaping (PresentablePublicKey) -> Void)
    {
        self.headerTitle = headerTitle
        self.headerSubtitle = headerSubtitle
        self.loadingTitle = loadingTitle
        self._viewModel = State(initialValue: viewModel)
        self.selection = selection
    }
    
    private let headerTitle: String
    private let headerSubtitle: String
    private let loadingTitle: String
    
    @State private var viewModel: PublicKeyViewModel
    
    private let selection: (PresentablePublicKey) -> Void
    
    public var body: some View {
        HeaderView(title: headerTitle, subtitle: headerSubtitle)
        
        if viewModel.onLoadingState {
            LoadingView(title: loadingTitle)
        } else {
            WalletListView(viewModel: viewModel,
                           selection: selection)
        }
        Spacer()
    }
}

struct WalletListUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletListUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List Test View")
        }
    }
    
    struct WalletListUIComposerTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                WalletListUIComposerView(
                    headerTitle: "Wallets",
                    headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your passwords and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                    loadingTitle: "Loading wallets",
                    viewModel: .init(publicKeys: [], handler: { selection = $0.id }),
                    selection: { selection = $0.id })
                WalletListUIComposerView(
                    headerTitle: "Wallets",
                    headerSubtitle: "Keychain is a secure storage area on your device that uses encryption to keep your passwords and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                    loadingTitle: "Loading wallets",
                    viewModel: .init(publicKeys: [
                        PresentablePublicKey(id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"),
                        PresentablePublicKey(id: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD"),
                        PresentablePublicKey(id: "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA")
                    ], handler: { selection = $0.id }),
                    selection: { selection = $0.id })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
