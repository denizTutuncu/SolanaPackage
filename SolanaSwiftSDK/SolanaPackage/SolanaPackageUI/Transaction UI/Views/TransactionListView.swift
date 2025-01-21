//
//  TransactionListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct TransactionListView: View {
    let viewModel: TransactionListViewModel
    let selection: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            List {
                ForEach(viewModel.model, id: \.id) { model in
                    SingleTransactionCellView(tx: model,
                                              selection: { selection(model.signature) })
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
            
            TransactionListView(viewModel: .init(model: [
                PresentableTransaction(date: "Feb 23, 2023",
                                       from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                       amount: "10000000000.0000",
                                       currencyName: "lamports",
                                       signature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                PresentableTransaction(date: "Feb 24, 2023",
                                       from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                       amount: "20000000000.0000",
                                       currencyName: "lamports",
                                       signature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
            ]),
                                selection: { selection = $0 } )
            
            Text("Last selection: " + selection).padding()
        }
    }
}
