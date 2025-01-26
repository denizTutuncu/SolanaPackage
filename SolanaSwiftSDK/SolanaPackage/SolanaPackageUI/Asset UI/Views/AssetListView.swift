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
                        PresentableAsset(name: "BTC", assetPrices: [AssetPrice(date: Date(), price: 14500)], imageURL: "An Image URL"),
                        PresentableAsset(name: "SOL", assetPrices: [AssetPrice(date: Date(), price: 256.20)], imageURL: "An Image URL"),
                        PresentableAsset(name: "RAY", assetPrices: [AssetPrice(date: Date(), price: 7.83)], imageURL: "An Image URL"),
                        PresentableAsset(name: "SHDW", assetPrices: [AssetPrice(date: Date(), price: 0.36)], imageURL: "An Image URL"),
                        PresentableAsset(name: "HNT", assetPrices: [AssetPrice(date: Date(), price: 24.08)], imageURL: "An Image URL"),
                        PresentableAsset(name: "JUP", assetPrices: [AssetPrice(date: Date(), price: 0.85)], imageURL: "An Image URL"),
                        PresentableAsset(name: "ZEUS", assetPrices: [AssetPrice(date: Date(), price: 0.58)], imageURL: "An Image URL"),
                        PresentableAsset(name: "BONK", assetPrices: [AssetPrice(date: Date(), price: 0.00003)], imageURL: "An Image URL"),
                        PresentableAsset(name: "GOBI", assetPrices: [AssetPrice(date: Date(), price: 0.00043)], imageURL: "An Image URL"),
                        PresentableAsset(name: "GLooM", assetPrices: [AssetPrice(date: Date(), price: 0.000047)], imageURL: "An Image URL")
                    ],
                    isLoading: false))

//                Text("Last selection: " + selection).padding()
            }
        }
    }
}

