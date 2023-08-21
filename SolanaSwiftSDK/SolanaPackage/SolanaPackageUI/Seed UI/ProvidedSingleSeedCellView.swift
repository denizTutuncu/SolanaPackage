//
//  ProvidedSingleSeedCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

struct ProvidedSingleSeedCellView: View {
    let index: Int
    @Binding var model: PresentableSeed
    @State private var isToggleOn: Bool = false
    
    private var isValueEmpty: Bool {
        return model.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        HStack {
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
            
            TextField("seed \(index)", text: $model.value)
                .font(.system(size: 21, weight: .bold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
                .onChange(of: model.value) { newValue in
                    model.value = newValue.lowercased()
                }
            
            
            Spacer()
            
            Toggle("", isOn: Binding<Bool>(
                get: { !self.isValueEmpty },
                set: { self.model.value = $0 ? "Value \(self.index + 1)" : "" }
            )
            )
            .disabled(isValueEmpty)
            .contrast(1.0)
        }
        .onAppear {
            isToggleOn = !isValueEmpty
        }
        .padding()
    }
}

struct ProvidedSingleSeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProvidedSingleSeedCellTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Provided Single Seed Cell View")
        }
    }
}

struct ProvidedSingleSeedCellTestView: View {
    var body: some View {
        VStack {
            ProvidedSingleSeedCellView(index: 1,
                                       model: .constant(PresentableSeed(value: "")))
            ProvidedSingleSeedCellView(index: 1,
                                       model: .constant(PresentableSeed(value: "value")))
        }
    }
}
