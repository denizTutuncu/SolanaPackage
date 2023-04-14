//
//  SingleWalletSelectionCell.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct SingleWalletSelectionCellView: View {
    @Binding var wallet: WalletUI
    let selection: () -> Void
    
    var body: some View {
        Button(action: selection,
               label: {
            HStack {
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .overlay(
                        Rectangle()
                            .fill(wallet.isSelected ? Color.blue : .clear)
                            .frame(width: 9.0, height: 9.0)
                    )
                    .frame(width: 13.0, height: 13.0)
                
                Text(wallet.id)
                    .font(.system(size: 36, weight: .black, design: .monospaced))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .foregroundColor(Color.primary)
            }
        }).padding()
        
    }
}

struct SingleWalletSelectionCell_Previews: PreviewProvider {
    @State var selection: String = "none"
    
    static var previews: some View {
        SingleWalletSelectionCellView(wallet: .constant(WalletUI(
            id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
            balance: "100.0")),
            selection: { })
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Single Wallet Selection Cell Test View")
    }
}
