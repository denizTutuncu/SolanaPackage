//
//  AssetListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 1/13/25.
//

import SwiftUI

public struct AssetListView: View {
    public init(headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                tryAgain: @escaping () -> Void,
                selection: @escaping (String) -> Void,
                viewModel: PresentableAssetListViewModel) {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.tryAgain = tryAgain
        self.selection = selection
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let tryAgain: () -> Void
    private let selection: (String) -> Void

    @ObservedObject private var viewModel: PresentableAssetListViewModel

    public var body: some View {
        VStack {
            HeaderView(
                title: headerTitle,
                titleTextColor: headerTitleTextColor,
                subtitle: headerSubtitle,
                subtitleTextColor: headerSubtitleTextColor
            )
            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
                Spacer()
            } else if viewModel.isModelEmpty {
                ErrorView(
                    message: errorMessage,
                    buttonTitle: errorViewButtonTitle,
                    onHide: { tryAgain() }
                )
            } else {
                List {
                    ForEach(viewModel.model, id: \ .id) { model in
                        SingleAssetSelectionCellView(asset: model, selection: { selection($0) })
                            .listRowSeparatorTint(.primary)
                    }
                }
            }
        }
    }
}

struct AssetListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssetListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Asset List Test View")
        }
    }

    struct AssetListTestView: View {
        @State var selection: String = "none"

        var body: some View {
            VStack {
                AssetListView(
                    headerTitle: "Solana Asset List",
                    headerTitleTextColor: .primary,
                    headerSubtitle: "Select an asset to view details.",
                    headerSubtitleTextColor: .blue,
                    errorMessage: "Cannot load assets",
                    errorViewButtonTitle: "Try Again",
                    loadingTitle: "Loading assets",
                    tryAgain: { },
                    selection: { selection = $0 },
                    viewModel: .init(model: [
                        PresentableAsset(name: "WBTC", assetDailyData: [AssetDailyData(date: Date(), open: 100005.75, high: 111111.11, low: 95750.75, close: 105650.25)], imageURL: "An Image URL"),
                        PresentableAsset(name: "SOL", assetDailyData: [AssetDailyData(date: Date(), open: 235.75, high: 255.55, low: 233.46, close: 252.52)], imageURL: "An Image URL"),
                        PresentableAsset(name: "RAY", assetDailyData: [AssetDailyData(date: Date(), open: 7.55, high: 8.12, low: 7.19, close: 7.25)], imageURL: "An Image URL"),
                        PresentableAsset(name: "SHDW", assetDailyData: [AssetDailyData(date: Date(), open: 0.35, high: 0.41, low: 0.31, close: 0.40)], imageURL: "An Image URL"),
                        PresentableAsset(name: "HNT", assetDailyData: [AssetDailyData(date: Date(), open: 4.05, high: 4.55, low: 4.01, close: 4.35)], imageURL: "An Image URL"),
                        PresentableAsset(name: "JUP", assetDailyData: [AssetDailyData(date: Date(), open: 0.83, high: 0.87, low: 0.80, close: 0.85)], imageURL: "An Image URL"),
                        PresentableAsset(name: "ZEUS", assetDailyData: [AssetDailyData(date: Date(), open: 0.55, high: 0.61, low: 0.51, close: 0.58)], imageURL: "An Image URL"),
                        PresentableAsset(name: "BONK", assetDailyData: [AssetDailyData(date: Date(), open: 0.000035, high: 0.000053, low: 0.000029, close: 0.00003)], imageURL: "An Image URL"),
                        PresentableAsset(name: "GOBI", assetDailyData: [AssetDailyData(date: Date(), open: 0.00041, high: 0.00056, low: 0.00034, close: 0.00043)], imageURL: "An Image URL"),
                        PresentableAsset(name: "GLooM", assetDailyData: [AssetDailyData(date: Date(), open: 0.000041, high: 0.000057, low: 0.000034, close: 0.000047)], imageURL: "An Image URL")
                    ],
                    isLoading: false))

//                Text("Last selection: " + selection).padding()
            }
        }
    }
}

