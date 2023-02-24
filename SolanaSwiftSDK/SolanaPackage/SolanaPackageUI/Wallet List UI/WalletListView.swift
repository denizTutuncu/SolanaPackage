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
    let publicKeys: [String]
    let selection: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: title, subtitle: subtitle)
            List {
                ForEach(publicKeys, id: \.self) { publicKey in
                    SingleWalletSelectionCell(publicKey: publicKey, selection: {
                        selection(publicKey)
                    })
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
                    publicKeys: ["4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                 "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                 "POhasdyasd454cxgcxT7yYUuyn6UgMJddBHKl21bhduA"],
                    selection: { selection = $0 }
                )
                
                Text("Last selection: " + selection).padding()
            }
        }
    }
}
