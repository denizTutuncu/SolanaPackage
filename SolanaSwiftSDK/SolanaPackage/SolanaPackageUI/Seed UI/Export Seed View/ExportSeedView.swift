//
//  ExportSeedView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

public struct ExportSeedView: View {
    public init(viewModel: ExportSeedViewModel,
                headerTitle: String,
                headerTitleTextColor: Color,
                headerSubtitle: String,
                headerSubtitleTextColor: Color,
                buttonTitle: String,
                errorMessage: String,
                errorViewButtonTitle: String,
                loadingTitle: String,
                loadAgain: @escaping () -> Void,
                action: @escaping () -> Void,
                actionButtonBackgroundColor: Color,
                backButtonTitle: String,
                backAction: @escaping () -> Void,
                backButtonBackgroundColor: Color
    ) {
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
        self.actionButtonBackgroundColor = actionButtonBackgroundColor
        self.backButtonTitle = backButtonTitle
        self.backAction = backAction
        self.backButtonBackgroundColor = backButtonBackgroundColor
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
    private let actionButtonBackgroundColor: Color
    private let backButtonTitle: String
    private let backAction: () -> Void
    private let backButtonBackgroundColor: Color

    @ObservedObject var viewModel: ExportSeedViewModel

    public var body: some View {
        VStack {
            HeaderView(title: headerTitle,
                       titleTextColor: headerTitleTextColor,
                       subtitle: headerSubtitle,
                       subtitleTextColor: headerSubtitleTextColor)

            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else if viewModel.model.isEmpty {
                ErrorView(message: errorMessage,
                          buttonTitle: errorViewButtonTitle,
                          onHide: loadAgain)
            } else {
                List {
                    ForEach(viewModel.model.indices, id: \..self) { index in
                        ExportSingleSeedCellView(
                            index: index,
                            model: Binding(
                                get: { viewModel.model[index] },
                                set: { newValue in
                                    viewModel.updateSeed(at: index, with: newValue)
                                }
                            )
                        )
                    }
                }
                VStack {
                    RoundedButton(title: buttonTitle,
                                  isEnabled: viewModel.canSubmit,
                                  action: action,
                                  backgroundColor: actionButtonBackgroundColor)
                    RoundedButton(title: backButtonTitle,
                                  isEnabled: true,
                                  action: backAction,
                                  backgroundColor: backButtonBackgroundColor)
                }
            }
        }
    }
}

struct ExportSeedView_Previews: PreviewProvider {
    static var previews: some View {
        ExportSeedView(
            viewModel: ExportSeedViewModel(model: [
                PresentableSeed(value: "seed"),
                PresentableSeed(value: "phrase"),
                PresentableSeed(value: "important"),
                PresentableSeed(value: "secure")
            ]),
            headerTitle: "Exported Seed Phrase",
            headerTitleTextColor: .primary,
            headerSubtitle: "Review your seed phrase to create your wallet.",
            headerSubtitleTextColor: .blue,
            buttonTitle: "Create New Wallet",
            errorMessage: "Cannot export the seed phrase at this time.",
            errorViewButtonTitle: "Try Again",
            loadingTitle: "Loading Seed Phrase...",
            loadAgain: { print("Load again button triggered") },
            action: { print("Action button triggered") },
            actionButtonBackgroundColor: .blue,
            backButtonTitle: "Back",
            backAction: { print("Back action button triggered") },
            backButtonBackgroundColor: .gray
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Export Seed Test View")
    }
}
