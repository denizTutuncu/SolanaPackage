//
//  ExportSingleSeedCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct ExportSingleSeedCellView: View {
    let index: Int
    @Binding var model: PresentableSeed

    var body: some View {
        HStack {
            Circle()
                .stroke(model.isSafe ? .blue : .red, lineWidth: 2.5)
                .frame(width: 29.0, height: 29.0)
                .overlay(
                    Text("\(index + 1)")
                        .font(.system(size: 21, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                )

            Text(model.value)
                .font(.system(size: 21, weight: .bold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)

            Spacer()

            Toggle("", isOn: Binding(
                get: { model.isSafe },
                set: { newValue in
                    model.isSafe = newValue
                }
            ))
        }
        .padding()
    }
}

struct ExportSingleSeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        ExportSingleSeedCellView(
            index: 0,
            model: .constant(PresentableSeed(value: "example", isSafe: true))
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Export Single Seed Cell View")
    }
}
