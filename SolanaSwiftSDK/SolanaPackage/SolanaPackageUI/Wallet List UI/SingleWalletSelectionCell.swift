//
//  SingleWalletSelectionCell.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import SwiftUI

struct SingleWalletSelectionCell: View {
    let publicKey: String
    let selection: () -> Void
    
    var body: some View {
        Button(action: selection, label: {
            HStack {
                Circle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .frame(width: 29.0, height: 29.0)
                
                Text(publicKey)
                    .font(.system(size: 21, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)
                
                Spacer()
            }.padding()
        })
    }
}

struct SingleWalletSelectionCell_Previews: PreviewProvider {
    static var previews: some View {
        SingleWalletSelectionCell(publicKey:"4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                  selection: {})
        .previewLayout(.sizeThatFits)
    }
}
