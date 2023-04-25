//
//  TransactionErrorComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct TransactionErrorComposerView: View {
    let errorMessage: String
    let onTryAgain: () -> Void
    let selection: (PresentableTransaction) -> Void
    
    @State var viewModel: TransactionViewModel?
    
    var body: some View {
        if viewModel != nil {
            TransactionListView(selection: selection,
                                viewModel: viewModel!)
        } else {
            ErrorView(message: errorMessage, onHide: onTryAgain)
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
    
    var body: some View {
        VStack {
            TransactionErrorComposerView(errorMessage: "Cannot load transactions.",
                                         onTryAgain: { },
                                         selection: { _ in },
                                         viewModel: nil)
            
            TransactionErrorComposerView(errorMessage: "Cannot load transactions.",
                                         onTryAgain: { },
                                         selection: { _ in },
                                         viewModel: .init(transactions: [PresentableTransaction(
                                            date: "Feb 23, 2023",
                                            from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                            to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                            amount: "10000000000.0000",
                                            currencyName: "lamports",
                                            transactionSignature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
                                         ]))
            
        }
    }
}
