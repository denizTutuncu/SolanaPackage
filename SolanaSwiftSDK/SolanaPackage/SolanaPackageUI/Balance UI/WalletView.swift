//
//  WalletView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import SwiftUI

struct WalletView: View {
    @State var title: String
    @State var amount: String
    @State var currencyName: String
    @State var address: String
    @State var network: String
  
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: address, subtitle: network)
            BalanceView(title: title, amount: amount, currencyName: currencyName)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletView(title: "Balance", amount: "100000000000000.0", currencyName: "lamports", address: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", network: "Solana")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet View")
        }
    }
}
