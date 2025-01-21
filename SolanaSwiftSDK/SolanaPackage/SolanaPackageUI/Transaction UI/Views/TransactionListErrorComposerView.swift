//
//  TransactionErrorComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct TransactionListErrorComposerView: View {
    let errorMessage: String
    let errorViewButtonTitle: String
    let onTryAgain: () -> Void
    
    let selection: (String) -> Void
    @State var viewModel: TransactionListViewModel
    
    var body: some View {
        if (!viewModel.model.isEmpty) {
            TransactionListView(viewModel: viewModel, selection: selection)
        } else {
            ErrorView(message: errorMessage, buttonTitle: errorViewButtonTitle, onHide: onTryAgain)
        }
    }
}

struct TransactionErrorComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionErrorComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Transaction Error Composer Test View")
        }
    }
}

struct TransactionErrorComposerTestView: View {
    @State var selection: String = "none"

    var body: some View {
        VStack {
            TransactionListErrorComposerView(errorMessage: "Cannot load transactions",
                                             errorViewButtonTitle: "Try again",
                                             onTryAgain: { selection = "Try again tapped" },
                                             selection: { _ in },
                                             viewModel: .init())
            
            TransactionListErrorComposerView(errorMessage: "",
                                             errorViewButtonTitle: "",
                                             onTryAgain: { },
                                             selection: { selection = $0 },
                                             viewModel: .init(model: [
                                                PresentableTransaction(date: "Feb 24, 2023",
                                                                       from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                                       amount: "10000000000.0000",
                                                                       currencyName: "lamports",
                                                                       signature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                                PresentableTransaction(date: "Feb 23, 2023",
                                                                       from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                                       amount: "20000000000.0000",
                                                                       currencyName: "lamports",
                                                                       signature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
                                             ]))
            
            Text("Last selection: " + selection).padding()

            
        }
    }
}
