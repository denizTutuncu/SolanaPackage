//
//  SingleSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct SingleSeedCellView: View {
    let index: Int
    let seed: String

    var body: some View {
            HStack {
                Circle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .frame(width: 29.0, height: 29.0)
                    .overlay(
                        Text("\(index)")
                            .foregroundColor(.primary)
                    )

                Text(seed)
                    .font(.system(size: 21, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Spacer()
            }.padding()
    }
}

struct SingleSeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        SingleSeedCellView(index: 1, seed:"seed")
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Single Seed Cell View")
    }
}
