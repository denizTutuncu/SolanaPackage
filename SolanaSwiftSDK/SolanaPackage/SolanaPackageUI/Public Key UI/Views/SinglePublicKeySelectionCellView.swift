//
//  SingleWalletSelectionCell.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct SinglePublicKeySelectionCellView: View {
    @State var publicKey: PresentablePublicKey
    let selection: (String) -> Void
    
    var body: some View {
        Button(action: { selection(publicKey.value); publicKey.toggleSelection() },
               label: {
            HStack {
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .overlay(
                        Rectangle()
                            .fill(publicKey.isSelected ? Color.blue : .clear)
                            .frame(width: 9.0, height: 9.0)
                    )
                    .frame(width: 13.0, height: 13.0)
                
                Text(publicKey.value)
                    .font(.system(size: 36, weight: .black, design: .monospaced))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .foregroundColor(Color.primary)
            }
        })
    }
}

struct SingleWalletSelectionCell_Previews: PreviewProvider {
    @State var selection: String = "none"
    
    static var previews: some View {
        SinglePublicKeySelectionCellView(publicKey: PresentablePublicKey(
            value: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump"),
                                         selection: { _ in })
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Single Wallet Selection Cell Test View")
    }
}
