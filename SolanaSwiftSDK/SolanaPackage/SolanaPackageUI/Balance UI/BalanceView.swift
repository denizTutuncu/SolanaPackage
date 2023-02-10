//
//  BalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//
import SwiftUI

struct BalanceView: View {
    @State private var title: String
    @State private var amount: String
    @State private var currencyName: String
    
    init(title: String, amount: String, currencyName: String) {
        self.title = title
        self.amount = amount
        self.currencyName = currencyName
    }
    
    var body: some View {
        HStack {
            Text(title)
                .lineLimit(1)
                .shadow(color: .primary, radius: 0.5)
                .padding()
                .foregroundColor(Color.primary)
            
            Text("\(amount) \(currencyName)")
                .lineLimit(1)
                .shadow(color: .primary, radius: 0.5)
                .padding()
                .foregroundColor(Color.primary)
            
            Spacer()
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceView(title: "Balance", amount: "10000000000", currencyName: "lamports")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance View")
        }
    }
}
