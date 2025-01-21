//
//  TransactionUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct TransactionListUIComposerView: View {
    let currencyName: String
    let errorMessage: String
    let errorViewButtonTitle: String
    let loadingTitle: String
    let tryAgain: () -> Void
    let selection: (String) -> Void
    
    @State var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView(title: loadingTitle)
            } else {
                TransactionListErrorComposerView(errorMessage: errorMessage,
                                                 errorViewButtonTitle: errorViewButtonTitle,
                                                 onTryAgain: tryAgain,
                                                 selection: selection,
                                                 viewModel: viewModel)
            }
        }
    }
}

struct TransactionUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Transaction List UI Composer Test View")
        }
    }
}

struct TransactionUIComposerTestView: View {
    @State var selection: String = "none"
    
    var body: some View {
        VStack {
            TransactionListUIComposerView(currencyName: "",
                                      errorMessage: "",
                                      errorViewButtonTitle: "",
                                      loadingTitle: "Loading transactions",
                                      tryAgain: { },
                                      selection: { _ in },
                                      viewModel: .init())
            
            TransactionListUIComposerView(currencyName: "lamports",
                                      errorMessage: "",
                                      errorViewButtonTitle: "",
                                      loadingTitle: "",
                                      tryAgain: { },
                                      selection: { selection = $0 },
                                      viewModel: .init(model: [
                                        PresentableTransaction(date: "Feb 24, 2023",
                                                               from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                               to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                               amount: "10000000000.000",
                                                               currencyName: "lamports",
                                                               signature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                        PresentableTransaction(date: "Feb 23, 2023",
                                                               from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                               to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                               amount: "20000000000.000",
                                                               currencyName: "lamports",
                                                               signature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
                                      ], isLoading: false))
            
            Text("Last selection: " + selection).padding()
            
        }
    }
}

