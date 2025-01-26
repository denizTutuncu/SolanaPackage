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
                
                if let latestPrice = asset.assetPrices.last?.price {
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
    SingleAssetSelectionCellView(asset: PresentableAsset(name: "SOL",
                                                         assetPrices: [
                                                            AssetPrice(date: Date().addingTimeInterval(-11 * 24 * 60 * 60), price: 180),
                                                            AssetPrice(date: Date().addingTimeInterval(-10 * 24 * 60 * 60), price: 175),
                                                            AssetPrice(date: Date().addingTimeInterval(-9 * 24 * 60 * 60), price: 160),
                                                            AssetPrice(date: Date().addingTimeInterval(-8 * 24 * 60 * 60), price: 175),
                                                            AssetPrice(date: Date().addingTimeInterval(-7 * 24 * 60 * 60), price: 190),
                                                            AssetPrice(date: Date().addingTimeInterval(-6 * 24 * 60 * 60), price: 180),
                                                            AssetPrice(date: Date().addingTimeInterval(-5 * 24 * 60 * 60), price: 175),
                                                            AssetPrice(date: Date().addingTimeInterval(-4 * 24 * 60 * 60), price: 170),
                                                            AssetPrice(date: Date().addingTimeInterval(-3 * 24 * 60 * 60), price: 180),
                                                            AssetPrice(date: Date().addingTimeInterval(-2 * 24 * 60 * 60), price: 190),
                                                            AssetPrice(date: Date().addingTimeInterval(-1 * 24 * 60 * 60), price: 220),
                                                            AssetPrice(date: Date(), price: 250)
                                                         ],
                                                         imageURL: "Any Image URL"),
                                 selection: { assetName in print(assetName) })
}


