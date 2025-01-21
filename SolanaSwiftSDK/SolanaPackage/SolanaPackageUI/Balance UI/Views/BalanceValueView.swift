//
//  BalanceValueView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/23.
//
import SwiftUI

public struct BalanceValueView: View {
    let model: String
    
    public var body: some View {
        HStack(alignment: .bottom, spacing: 8.0) {
            Text(model)
                .font(.largeTitle)
                .minimumScaleFactor(0.2)
                .lineLimit(1)
                .foregroundColor(Color.primary)
                .shadow(color: .primary, radius: 0.5)
            
            
            Spacer()
        }.padding()
    }
}


struct BalanceTestView_Previews: PreviewProvider {
    static var previews: some View {
            BalanceValueView(model: "10000000000.0000")
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Balance Value Test View")
    }
}

