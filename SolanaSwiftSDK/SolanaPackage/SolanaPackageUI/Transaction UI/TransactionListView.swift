//
//  TransactionListView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import SwiftUI

struct TransactionListView: View {
    let title: String
    let subtitle: String
    @State var store: TransactionViewModel
    let selection: (TransactionUI) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: title, subtitle: subtitle)
            List {
                ForEach(store.transactions.indices, id: \.self) { i in
                    SingleTransactionCellView(tx: $store.transactions[i], selection: { selection(store.transactions[i]) })
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
            
            TransactionListView(title: "Transaction List",
                                subtitle: "Past transactions are stored here.",
                                store: .init(transactions: [
                                    TransactionUI(date: "Feb 23, 2023",
                                                from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                amount: "10000000000.00",
                                                currencyName: "lamports",
                                                transactionSignature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                    TransactionUI(date: "Feb 24, 2023",
                                                from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                amount: "20000000000.00",
                                                currencyName: "lamports",
                                                transactionSignature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
                                ]),
                                selection: { selection = $0.transactionSignature })
            
            Text("Last selection: " + selection).padding()
        }
    }
}


