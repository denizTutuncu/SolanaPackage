//
//  BalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//
import SwiftUI

public struct BalanceView: View {
    private let title: String
    private let currencyName: String
    @Binding var wallet: WalletUI?
    
    public init(title: String, currencyName: String, wallet: Binding<WalletUI?>) {
        self.title = title
        self.currencyName = currencyName
        self._wallet = wallet
    }
    
    public var body: some View {
            HStack(alignment: .bottom, spacing: 8.0) {
              
                Text(title)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                    .shadow(color: .primary, radius: 0.5)
                   
                if wallet != nil {
                    Text("\(wallet!.balance) \(currencyName)")
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color.primary)
                        .shadow(color: .primary, radius: 0.5)
                }
                  
                Spacer()
            }.padding()
    }
}


struct BalanceTestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceView(title: "Balance",
                        currencyName: "lamports",
                        wallet: .constant(WalletUI(id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                   balance: "1000.0")))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance Test View")
        }
    }
}

