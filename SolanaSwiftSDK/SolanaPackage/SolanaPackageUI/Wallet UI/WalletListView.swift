//
//  WalletListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct WalletListView: View {
    let title: String
    let subtitle: String
    @State var store: WalletStore
    
    let selection: (WalletUI) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: title, subtitle: subtitle)
            List {
                ForEach(store.wallets.indices, id: \.self) { i in
                    SingleWalletSelectionCellView(wallet: $store.wallets[i],
                                                  selection: { selection(store.wallets[i].toggleSelection())} )
                }
            }
            Spacer()
        }
    }
}

struct WalletListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet List Test View")
        }
    }
    
    struct WalletListTestView: View {
        @State var selection: String = "none"
        
        var body: some View {
            VStack {
                WalletListView(
                    title: "Wallets",
                    subtitle: "Keychain is a secure storage area on your device that uses encryption to keep your passwords and other sensitive information safe. It's an important tool for protecting your personal data from unauthorized access.",
                    store: .init(wallets: [
                        WalletUI(id: UUID(),
                                 publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                 balance: "1.0"),
                        WalletUI(id: UUID(),
                                 publicKey: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                 balance: "1.0"),
                        WalletUI(id: UUID(),
                                 publicKey: "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA",
                                 balance: "1.0")
                    ], handler: { selection = $0.publicKey }),
                    selection: { selection = $0.publicKey })
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
