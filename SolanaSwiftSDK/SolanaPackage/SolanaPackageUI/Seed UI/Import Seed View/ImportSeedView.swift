//
//  ImportSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 8/19/23.
//

import SwiftUI

public struct ImportSeedView: View {
    @ObservedObject var viewModel: ImportSeedViewModel

    public init(viewModel: ImportSeedViewModel,
                headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                buttonTitle: String,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                action: @escaping () -> Void) {
        self.viewModel = viewModel
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.buttonTitle = buttonTitle
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadingTitle = loadingTitle
        self.loadAgain = loadAgain
        self.action = action
    }

    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let buttonTitle: String
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadingTitle: String
    private let loadAgain: () -> Void
    private let action: () -> Void

    public var body: some View {
        VStack {
            HeaderView(title: headerTitle,
                       titleTextColor: headerTitleTextColor,
                       subtitle: headerSubtitle,
                       subtitleTextColor: headerSubtitleTextColor)

            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else if viewModel.model.isEmpty {
                ErrorView(
                    message: errorMessage,
                    buttonTitle: errorViewButtonTitle,
                    onHide: loadAgain
                )
            } else {
                List {
                    ForEach(viewModel.model.indices, id: \..self) { index in
                        ImportSingleSeedCellView(
                            index: index,
                            value: $viewModel.model[index].value,
                            onValueChange: { newValue in
                                viewModel.model[index].value = newValue
                            }
                        )
                    }
                }
                RoundedButton(title: buttonTitle, isEnabled: viewModel.canSubmit, action: action)
            }
        }
    }
}

struct ImportSeedView_Previews: PreviewProvider {
    static var previews: some View {
        ImportSeedView(
            viewModel: ImportSeedViewModel(model: [
                PresentableSeed(value: "seed"),
                PresentableSeed(value: "phrase"),
                PresentableSeed(value: "important"),
                PresentableSeed(value: "")
            ]),
            headerTitle: "Import Seed Phrase",
            headerTitleTextColor: .primary,
            headerSubtitle: "Enter your seed phrase to import your wallet.",
            headerSubtitleTextColor: .blue,
            buttonTitle: "Import Wallet",
            errorMessage: "Cannot import the seed phrase at this time.",
            errorViewButtonTitle: "Try Again",
            loadingTitle: "Loading Seed Phrase...",
            loadAgain: {},
            action: {}
        )
    }
}
