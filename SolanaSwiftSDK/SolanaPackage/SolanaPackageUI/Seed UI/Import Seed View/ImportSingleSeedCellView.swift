//
//  ImportSingleSeedCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

struct ImportSingleSeedCellView: View {
    let index: Int
    @Binding var model: PresentableSeed

    private var isValueEmpty: Bool {
        model.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack {
            // Circle color changes dynamically based on `isValueEmpty`
            Circle()
                .stroke(isValueEmpty ? Color.red : Color.blue, lineWidth: 2.5)
                .frame(width: 29.0, height: 29.0)
                .overlay(
                    Text("\(index)")
                        .font(.system(size: 21, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                )

            // TextField for seed input
            TextField("seed \(index)", text: Binding<String>(
                get: { model.value },
                set: { newValue in
                    model.value = newValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    model.isSafe = !model.value.isEmpty // Automatically update `isSafe`
                }
            ))
            .font(.system(size: 21, weight: .bold))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .foregroundColor(.primary)

            Spacer()

            // Toggle that reflects `isSafe`
            Toggle("", isOn: Binding<Bool>(
                get: { !isValueEmpty },
                set: { newValue in
                    model.isSafe = newValue
                    if !newValue {
                        model.value = ""
                    }
                }
            ))
            .disabled(isValueEmpty)
            .contrast(1.0)
        }
        .padding()
    }
}


struct ImportSingleSeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImportSingleSeedCellTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Import Single Seed Cell View")
        }
    }
}

struct ImportSingleSeedCellTestView: View {
    var body: some View {
        VStack {
            ImportSingleSeedCellView(index: 1,
                                       model: .constant(PresentableSeed(value: "")))
            ImportSingleSeedCellView(index: 1,
                                       model: .constant(PresentableSeed(value: "value")))
        }
    }
}
