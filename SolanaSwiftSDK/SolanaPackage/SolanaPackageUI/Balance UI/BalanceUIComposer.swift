//
//  BalancUIComposer.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/16/23.
//

import SwiftUI

struct BalanceUIComposer: View {
    let title: String
    let currencyName: String
    let errorMessage: String
    let errorButtonTitle: String
    let loadingTitle: String
    let tryAgain: () -> Void
    
    @State var viewModel: BalanceViewModel
    @Binding var loading: Bool
    
    var body: some View {
        if loading {
            LoadingView(title: loadingTitle)
            Spacer()
        } else {
            
            if viewModel.isModelEmpty {
                ErrorView(message: errorMessage, buttonTitle: errorButtonTitle, onHide: tryAgain)
            } else {
                HStack(alignment: .center, spacing: 8.0) {
                    Text(title)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color.primary)
                        .shadow(color: .primary, radius: 0.5)
                    
                    BalanceView(model: viewModel.model.value)
                    Text(currencyName)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(Color.primary)
                        .shadow(color: .primary, radius: 0.5)
                    
                }.padding()
            }
        }
    }
}

struct BalancUIComposer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Balance UI Composer Test View")
        }
    }
}

struct BalanceUIComposerTestView: View {
    
    var body: some View {
        VStack {
            BalanceUIComposer(title: "",
                              currencyName: "",
                              errorMessage: "",
                              errorButtonTitle: "",
                              loadingTitle: "Loading balance.",
                              tryAgain: {} ,
                              viewModel: .init(model: PresentableBalance(value: "")),
                              loading: .constant(true))
            
            BalanceUIComposer(title: "",
                              currencyName: "",
                              errorMessage: "Cannot load balancce",
                              errorButtonTitle: "Try again",
                              loadingTitle: "Loading balance.",
                              tryAgain: {} ,
                              viewModel: .init(model: PresentableBalance(value: "")),
                              loading: .constant(false))
            
            BalanceUIComposer(title: "Balance:",
                              currencyName: "lamports",
                              errorMessage: "Cannot connect to network",
                              errorButtonTitle: "Try again",
                              loadingTitle: "Loading balance.",
                              tryAgain: {},
                              viewModel: .init(model: PresentableBalance(value: "10000000000.0000")),
                              loading: .constant(false))
            
        }
    }
}
