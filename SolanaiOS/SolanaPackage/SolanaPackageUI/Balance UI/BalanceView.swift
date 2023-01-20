//
//  BalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//

import SwiftUI
import SolanaPackage

public struct BalanceView: View {
    @Binding var balance: String
    @Binding var color: Color
    
    public var body: some View {
        HStack {
            Text("\(balance) lamports")
                .font(Font.title)
                .italic()
                .shadow(color: Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)), radius: 3)
        }
        .foregroundColor(color)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceView(balance: .constant("10000000"), color: .constant(.blue))
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance View")
        }
    }
}
