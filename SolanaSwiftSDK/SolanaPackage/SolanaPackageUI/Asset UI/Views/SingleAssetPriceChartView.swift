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
            } else if viewModel.model.prices.isEmpty {
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: loadAgain)
            } else {
                Chart(viewModel.model.prices.indices, id: \ .self) { index in
                    LineMark(
                        x: .value("Index", index),
                        y: .value("Price", viewModel.model.prices[index])
                    )
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: (viewModel.model.prices.min()! - 10)...(viewModel.model.prices.max()! + 10))
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
        @State var selection: String = "none"
        
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
                                                                                                 prices: [185.50,
                                                                                                          175.25,
                                                                                                          169.75,
                                                                                                          172.68,
                                                                                                          179.98,
                                                                                                          195.25,
                                                                                                          202.20,
                                                                                                          212.12,
                                                                                                          230.38,
                                                                                                          240.50,
                                                                                                          258.58],
                                                                                                 imageURL: "An Image URL"),
                                                                         isLoading: false
                                    ))
            }
        }
    }
}
