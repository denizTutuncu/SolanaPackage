//
//  BalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//
import SwiftUI

public struct BalanceView: View {
    private let title: String
    private let amount: String
    private let currencyName: String
    
    public init(title: String, amount: String, currencyName: String) {
        self.title = title
        self.amount = amount
        self.currencyName = currencyName
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 28, weight: .thin))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                    .shadow(color: .primary, radius: 0.5)
                   
                
                Text("\(amount) \(currencyName)")
                    .font(.system(size: 24, weight: .light))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                    .shadow(color: .primary, radius: 0.5)
                   
                Spacer()
            } .padding()
        }
    }
}


struct BalanceTestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceView(title: "Balance", amount: "\(10000000000.0)", currencyName: "lamports")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance Test View")
        }
    }
}
