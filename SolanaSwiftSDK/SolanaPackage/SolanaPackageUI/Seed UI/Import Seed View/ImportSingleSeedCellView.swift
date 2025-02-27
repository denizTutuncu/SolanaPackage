//
//  ImportSingleSeedCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

struct ImportSingleSeedCellView: View {
    let index: Int
    @Binding var value: String
    var onValueChange: (String) -> Void

    private var isValueValid: Bool {
        value.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
    }

    var body: some View {
        HStack {
            Circle()
                .stroke(isValueValid ? Color.blue : Color.red, lineWidth: 2.5)
                .frame(width: 29.0, height: 29.0)
                .overlay(
                    Text("\(index + 1)")
                        .font(.system(size: 21, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                )

            TextField("Seed \(index + 1)", text: Binding(
                get: { value },
                set: { newValue in
                    let lowercasedValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    value = lowercasedValue
                    onValueChange(lowercasedValue)
                }
            ))
            .font(.system(size: 21, weight: .bold))
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)

            Spacer()

            Toggle("", isOn: .constant(isValueValid))
                .disabled(true)
        }
        .padding()
    }
}

struct ImportSingleSeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        ImportSingleSeedCellTestView()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Import Single Seed Cell View")
    }
}

struct ImportSingleSeedCellTestView: View {
    @State private var value1 = ""
    @State private var value2 = "Value"

    var body: some View {
        VStack {
            ImportSingleSeedCellView(
                index: 0,
                value: $value1,
                onValueChange: { newValue in
                    value1 = newValue
                }
            )
            ImportSingleSeedCellView(
                index: 1,
                value: $value2,
                onValueChange: { newValue in
                    value2 = newValue
                }
            )
        }
        .padding()
    }
}
