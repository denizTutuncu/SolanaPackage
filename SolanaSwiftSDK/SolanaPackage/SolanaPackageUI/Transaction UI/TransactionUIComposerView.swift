//
//  TransactionUIComposerView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/18/23.
//

import SwiftUI

struct TransactionUIComposerView: View {
    let currencyName: String
    let errorMessage: String
    let downloadingTitle: String
    let tryAgain: () -> Void
    let selection: (PresentableTransaction) -> Void
    
    @State var onLoadingState: Bool = true
    @State var viewModel: TransactionViewModel?
    
    var body: some View {
        if onLoadingState {
            LoadingView(title: downloadingTitle).padding()
        } else {
            TransactionErrorComposerView(errorMessage: errorMessage,
                                         onTryAgain: tryAgain,
                                         selection: selection,
                                         viewModel: viewModel)
        }
    }
}



struct TransactionUIComposerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionUIComposerTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Transaction UI Composer Test View")
        }
    }
}

struct TransactionUIComposerTestView: View {
    @State var isON: Bool = false
    
    var body: some View {
        VStack {
            TransactionUIComposerView(currencyName: "",
                                      errorMessage: "",
                                      downloadingTitle: "Downloading transactions",
                                      tryAgain: { },
                                      selection: { _ in },
                                      onLoadingState: true,
                                      viewModel: nil)
            
            TransactionUIComposerView(currencyName: "lamports",
                                      errorMessage: "Cannot connect to network.",
                                      downloadingTitle: "Downloading balance",
                                      tryAgain: { },
                                      selection: { _ in },
                                      onLoadingState: false,
                                      viewModel: .init(transactions: [
                                        PresentableTransaction(date: "Feb 23, 2023",
                                                               from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                               to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                               amount: "10000000000.0000",
                                                               currencyName: "lamports",
                                                               transactionSignature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                        PresentableTransaction(date: "Feb 24, 2023",
                                                               from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                               to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                               amount: "20000000000.0000",
                                                               currencyName: "lamports",
                                                               transactionSignature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn")
                                      ]))
            
        }
    }
}

