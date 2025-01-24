//
//  TransactionListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct TransactionListView: View {
    
    init(headerTitle: String,
         headerTitleTextColor: Color,
         headerSubtitle: String,
         headerSubtitleTextColor: Color,
         loadingTitle: String,
         errorMessage: String,
         errorViewButtonTitle: String,
         loadAgain: @escaping () -> Void,
         selection: @escaping (String) -> Void,
         viewModel: TransactionListViewModel)
    {
        self.headerTitle = headerTitle
        self.headerTitleTextColor = headerTitleTextColor
        self.headerSubtitle = headerSubtitle
        self.headerSubtitleTextColor = headerSubtitleTextColor
        self.loadingTitle = loadingTitle
        self.errorMessage = errorMessage
        self.errorViewButtonTitle = errorViewButtonTitle
        self.loadAgain = loadAgain
        self.selection = selection
        self.viewModel = viewModel
    }
    
    private let headerTitle: String
    private let headerTitleTextColor: Color
    private let headerSubtitle: String
    private let headerSubtitleTextColor: Color
    private let loadingTitle: String
    private let errorMessage: String
    private let errorViewButtonTitle: String
    private let loadAgain: () -> Void
    private let selection: (String) -> Void
    private let viewModel: TransactionListViewModel
    
    var body: some View {
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
                    ForEach(viewModel.model, id: \.id) { model in
                        SingleTransactionCellView(tx: model,
                                                  selection: { selection(model.signature) })
                    }
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionListTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Transaction List Test View")
        }
    }
}

struct TransactionListTestView: View {
    @State var selection: String = "none"
    
    var body: some View {
        VStack {
            TransactionListView(headerTitle: "Transactions",
                                headerTitleTextColor: .primary,
                                headerSubtitle: "Past transactions are stored here.",
                                headerSubtitleTextColor: .blue,
                                loadingTitle: "Loading transactions...",
                                errorMessage: "Cannot load transactions",
                                errorViewButtonTitle: "Try again",
                                loadAgain: { print("Load again triggered") },
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

