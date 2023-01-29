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
                .italic()
                .shadow(color: Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)), radius: 3)
                .padding()
                .foregroundColor(Color.blue)
            
            Text("\(amount) \(currencyName)")
                .italic()
                .lineLimit(1)
                .shadow(color: Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)), radius: 3)
                .padding()
                .foregroundColor(Color.blue)
            
            Spacer()
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceView(title: "Bakiye:", amount: "100000000", currencyName: "lamports")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance View")
        }
    }
}
