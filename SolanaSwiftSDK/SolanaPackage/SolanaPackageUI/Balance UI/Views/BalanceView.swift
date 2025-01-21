//
//  BalanceView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import SwiftUI

struct BalanceView: View {
    let title: String
    let currencyName: String
    let loadingTitle: String
    let onTryAgain: () -> Void
    
    @State var viewModel: PresentableBalanceViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage, buttonTitle: "Try Again", onHide: onTryAgain)
            } else {
                HStack {
                    Text(title)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .shadow(color: .primary, radius: 0.5)

                    Text(viewModel.model.value)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .shadow(color: .primary, radius: 0.5)

                    Text(currencyName)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                        .shadow(color: .primary, radius: 0.5)
                }
                .padding()
            }
        }
    }
}


struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance Test View")
        }
    }
}

struct BalanceTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Test case: Loading view
            BalanceView(
                title: "",
                currencyName: "",
                loadingTitle: "Loading balance",
                onTryAgain: {},
                viewModel: .init(
                    model: PresentableBalance(value: "0.000"),
                    isLoading: true
                )
            )
            
            // Test case: Error view
            BalanceView(
                title: "",
                currencyName: "",
                loadingTitle: "Loading balance",
                onTryAgain: {},
                viewModel: .init(
                    model: PresentableBalance(value: ""),
                    isLoading: false,
                    errorMessage: "Cannot load balance"
                )
            )
            
            // Test case: Balance view
            BalanceView(
                title: "Balance:",
                currencyName: "lamports",
                loadingTitle: "Loading balance.",
                onTryAgain: {},
                viewModel: .init(
                    model: PresentableBalance(value: "10000000000.000"),
                    isLoading: false
                )
            )
        }
    }
}
