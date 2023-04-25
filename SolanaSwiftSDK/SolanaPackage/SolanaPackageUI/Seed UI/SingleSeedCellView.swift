//
//  SingleSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct SingleSeedCellView: View {
    let index: Int
    @Binding var seed: PresentableSeed
    
    var body: some View {
        HStack {
            Circle()
                .stroke(Color.secondary, lineWidth: 2.5)
                .frame(width: 29.0, height: 29.0)
                .overlay(
                    Text("\(index)")
                        .font(.system(size: 21, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                )
            
            Text(seed.value)
                .font(.system(size: 21, weight: .bold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            Spacer()
          
            Toggle("", isOn: $seed.isSafe)
                .contrast(100.0)
            Text(seed.isSafe ? "✅" : "❌")
                .font(.system(size: 21, weight: .bold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
            
        }.padding()
    }
}

struct SingleSeedCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SingleSeedCellView(index: 1,
                               seed: .constant(PresentableSeed(value: "seed"))
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Single Seed Cell View")
            
        }
    }
}
