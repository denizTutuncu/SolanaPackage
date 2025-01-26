//
//  SingleAssetPriceChartView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/25/25.
//

import SwiftUI
import Charts

public struct SingleAssetPriceChartView: View {
    public init(title: String,
                titleTextColor: Color,
                subtitle: String,
                subtitleTextColor: Color,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                viewModel: PresentableAssetViewModel) {
        self.title = title
        self.titleTextColor = titleTextColor
        self.subtitle = subtitle
        self.subtitleTextColor = subtitleTextColor
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.loadAgain = loadAgain
        self.viewModel = viewModel
    }
    
    private let title: String
    private let titleTextColor: Color
    private let subtitle: String
    private let subtitleTextColor: Color
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let loadAgain: () -> Void
    
    @ObservedObject private var viewModel: PresentableAssetViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: title,
                       titleTextColor: titleTextColor,
                       subtitle: subtitle,
                       subtitleTextColor: subtitleTextColor)
            
            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else if viewModel.model.assetPrices.isEmpty {
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: loadAgain)
            } else {
                Chart(viewModel.model.assetPrices.indices, id: \.self) { index in
                    LineMark(
                        x: .value("Date", viewModel.model.assetPrices[index].date),
                        y: .value("Price", viewModel.model.assetPrices[index].price)
                    )
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: viewModel.priceRange ?? 0...1)
                .frame(height: 300)
                .padding()
            }
        }
    }
}

struct AssetPriceChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssetPriceChartTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Asset Price Chart Test View")
        }
    }
    
    struct AssetPriceChartTestView: View {
        
        var body: some View {
            VStack {
                SingleAssetPriceChartView(title: "Solana",
                                          titleTextColor: .primary,
                                          subtitle: "Daily Price Chart",
                                          subtitleTextColor: .blue,
                                          errorMessage: "Cannot load asset price chart",
                                          errorViewButtonTitle: "Retry",
                                          loadingTitle: "Loading asset price chart...",
                                          loadAgain: { print("Load again button tapped")},
                                          viewModel: PresentableAssetViewModel(model: PresentableAsset(name: "SOL",
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
                                                                                                       imageURL: "An Image URL"),
                                                                               isLoading: false
                                          ))
            }
        }
    }
}
