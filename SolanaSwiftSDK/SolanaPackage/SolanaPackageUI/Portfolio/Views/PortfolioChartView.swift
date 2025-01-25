//
//  PortfolioChartView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/24/25.
//

import SwiftUI
import Charts

public struct PortfolioChartView: View {
    public init(title: String,
                titleTextColor: Color,
                subtitle: String,
                subtitleTextColor: Color,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                viewModel: PortfolioViewModel) {
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
    
    @ObservedObject private var viewModel: PortfolioViewModel

    public var body: some View {
        VStack {
            HeaderView(title: title,
                       titleTextColor: titleTextColor,
                       subtitle: subtitle,
                       subtitleTextColor: subtitleTextColor)

            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else if viewModel.model.isEmpty {
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: loadAgain)
            } else {
                Chart(viewModel.model) { portfolio in
                    LineMark(
                        x: .value("Date", portfolio.date),
                        y: .value("Value", portfolio.value)
                    )
                    .symbol(Circle())
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: (viewModel.model.map { $0.value }.min()! - 500)...(viewModel.model.map { $0.value }.max()! + 500))
                .frame(height: 300)
                .padding()
            }
        }
    }
}

struct PortfolioChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioChartTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Portfolio Chart Test View")
        }
    }
    
    struct PortfolioChartTestView: View {
        let sampleViewModel = PortfolioViewModel(model: [
            Portfolio(date: Date().addingTimeInterval(-11 * 24 * 60 * 60), value: 7500),
            Portfolio(date: Date().addingTimeInterval(-10 * 24 * 60 * 60), value: 8500),
            Portfolio(date: Date().addingTimeInterval(-9 * 24 * 60 * 60), value: 9000),
            Portfolio(date: Date().addingTimeInterval(-8 * 24 * 60 * 60), value: 10000),
            Portfolio(date: Date().addingTimeInterval(-7 * 24 * 60 * 60), value: 9000),
            Portfolio(date: Date().addingTimeInterval(-6 * 24 * 60 * 60), value: 10000),
            Portfolio(date: Date().addingTimeInterval(-5 * 24 * 60 * 60), value: 10500),
            Portfolio(date: Date().addingTimeInterval(-4 * 24 * 60 * 60), value: 8250),
            Portfolio(date: Date().addingTimeInterval(-3 * 24 * 60 * 60), value: 10750),
            Portfolio(date: Date().addingTimeInterval(-2 * 24 * 60 * 60), value: 9500),
            Portfolio(date: Date().addingTimeInterval(-1 * 24 * 60 * 60), value: 15500),
            Portfolio(date: Date(), value: 14500)
        ], isLoading: false)
        
        var body: some View {
            VStack {
                PortfolioChartView(title: "Portfolio Performance",
                                   titleTextColor: .primary,
                                   subtitle: "Monitor Your Portfolio Progress Daily",
                                   subtitleTextColor: .blue,
                                   errorMessage: "Unable to load portfolio data at this time.",
                                   errorViewButtonTitle: "Retry",
                                   loadingTitle: "Loading Portfolio...",
                                   loadAgain: { print("Retry button tapped") },
                                   viewModel: sampleViewModel)
            }
        }
    }
}
