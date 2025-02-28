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
            } else if viewModel.model.assetDailyData.isEmpty {
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: loadAgain)
            } else {
                Chart(viewModel.model.assetDailyData.indices, id: \.self) { index in
                    let data = viewModel.model.assetDailyData[index]
                    
                    RuleMark(
                        x: .value("Date", data.date),
                        yStart: .value("Low", data.low),
                        yEnd: .value("High", data.high)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 1))
                    .foregroundStyle(data.close > data.open ? .green : .red)
                    
                    // Body: Open to Close
                    RectangleMark(
                        x: .value("Date", data.date),
                        yStart: .value("Open", data.open),
                        yEnd: .value("Close", data.close)
                    )
                    .foregroundStyle(data.close > data.open ? .green : .red)
                    .cornerRadius(1)
                    .opacity(0.8)
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
                .previewDisplayName("Single Asset Price Chart Test View")
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
                                          loadAgain: { print("Load again button tapped") },
                                          viewModel: PresentableAssetViewModel(model: PresentableAsset(name: "SOL",
                                                                                                       assetDailyData: [
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-11 * 24 * 60 * 60), open: 175, high: 185, low: 170, close: 180),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-10 * 24 * 60 * 60), open: 180, high: 185, low: 165, close: 175),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-9 * 24 * 60 * 60), open: 175, high: 180, low: 150, close: 160),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-8 * 24 * 60 * 60), open: 160, high: 180, low: 155, close: 175),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-7 * 24 * 60 * 60), open: 175, high: 195, low: 170, close: 190),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-6 * 24 * 60 * 60), open: 190, high: 200, low: 185, close: 195),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-5 * 24 * 60 * 60), open: 195, high: 205, low: 190, close: 200),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-4 * 24 * 60 * 60), open: 200, high: 210, low: 195, close: 205),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-3 * 24 * 60 * 60), open: 205, high: 215, low: 200, close: 210),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-2 * 24 * 60 * 60), open: 210, high: 220, low: 205, close: 215),
                                                                                                        AssetDailyData(date: Date().addingTimeInterval(-1 * 24 * 60 * 60), open: 215, high: 225, low: 210, close: 220),
                                                                                                        AssetDailyData(date: Date(), open: 220, high: 260, low: 215, close: 250)
                                                                                                    ],
                                                                                                       imageURL: "An Image URL"),
                                                                               isLoading: false
                                          ))
            }
        }
    }
}
