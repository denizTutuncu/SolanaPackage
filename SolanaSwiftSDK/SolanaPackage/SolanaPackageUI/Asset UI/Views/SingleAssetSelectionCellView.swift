//
//  SingleAssetSelectionCellView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/12/25.
//

import SwiftUI

public struct SingleAssetSelectionCellView: View {
    public init(asset: PresentableAsset, selection: @escaping (String) -> Void) {
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
                
                if let latestClosePrice = asset.assetDailyData.last?.close {
                    Text("$\(latestClosePrice, specifier: "%.2f")")
                        .font(.system(size: 28, weight: .light, design: .monospaced))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(Color.primary)
                }
            }
        }
    }
}

#Preview {
    SingleAssetSelectionCellView(
        asset: PresentableAsset(
            name: "SOL",
            assetDailyData: [
                AssetDailyData(date: Date().addingTimeInterval(-11 * 24 * 60 * 60), open: 175, high: 185, low: 170, close: 180),
                AssetDailyData(date: Date().addingTimeInterval(-10 * 24 * 60 * 60), open: 180, high: 185, low: 165, close: 175),
                AssetDailyData(date: Date().addingTimeInterval(-9 * 24 * 60 * 60), open: 175, high: 180, low: 150, close: 160),
                AssetDailyData(date: Date().addingTimeInterval(-8 * 24 * 60 * 60), open: 160, high: 180, low: 155, close: 175),
                AssetDailyData(date: Date().addingTimeInterval(-7 * 24 * 60 * 60), open: 175, high: 195, low: 170, close: 190),
                AssetDailyData(date: Date().addingTimeInterval(-6 * 24 * 60 * 60), open: 190, high: 200, low: 175, close: 180),
                AssetDailyData(date: Date().addingTimeInterval(-5 * 24 * 60 * 60), open: 180, high: 190, low: 170, close: 175),
                AssetDailyData(date: Date().addingTimeInterval(-4 * 24 * 60 * 60), open: 175, high: 180, low: 160, close: 170),
                AssetDailyData(date: Date().addingTimeInterval(-3 * 24 * 60 * 60), open: 170, high: 185, low: 165, close: 180),
                AssetDailyData(date: Date().addingTimeInterval(-2 * 24 * 60 * 60), open: 180, high: 195, low: 175, close: 190),
                AssetDailyData(date: Date().addingTimeInterval(-1 * 24 * 60 * 60), open: 190, high: 230, low: 185, close: 220),
                AssetDailyData(date: Date(), open: 220, high: 260, low: 215, close: 250)
            ],
            imageURL: "Any Image URL"
        ),
        selection: { assetName in
            print(assetName)
        }
    )
}
