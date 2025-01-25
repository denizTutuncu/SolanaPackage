//
//  SingleAssetSelectionCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/25.
//

import SwiftUI

public struct SingleAssetSelectionCellView: View {
    public init (asset: PresentableAsset, selection: @escaping (String) -> Void) {
        self.asset = asset
        self.selection = selection
    }

    @State private var asset: PresentableAsset
    private let selection: (String) -> Void

    public var body: some View {
        Button {
            selection(asset.name)
            asset.toggleSelection()
        } label: {
            HStack {
                Text(asset.name)
                    .font(.system(size: 36, weight: .black, design: .monospaced))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .foregroundColor(Color.primary)

                Spacer()

                if let latestPrice = asset.prices.last {
                    Text("$\(latestPrice, specifier: "%.2f")")
                        .font(.system(size: 28, weight: .light, design: .monospaced))
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .foregroundColor(Color.primary)
                }
            }
        }
    }
}

#Preview {
    SingleAssetSelectionCellView(asset: PresentableAsset(name: "SOL", prices: [182.20, 187.50, 195.87, 210.32, 258.58], imageURL: "s"),
                                 selection: { assetName in print(assetName) })
}
