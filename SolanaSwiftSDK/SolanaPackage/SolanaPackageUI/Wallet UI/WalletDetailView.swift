//
//  WalletDetailView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import SwiftUI

public struct WalletDetailView: View {
    
    public init(publicKey: String,
                network: String,
                currency: String,
                balanceLabelTitle: String,
                balanceLoadingTitle: String,
                balanceErrorMessage: String,
                balanceErrorButtonTitle: String,
                transactionListTitle: String,
                transactionListSubtitle: String,
                transactionLoadingTitle: String,
                transactionErrorMessage: String,
                transactionErrorButtonTitle: String,
                transactionSelection: @escaping (String) -> Void,
                tryLoadBalance: @escaping (String?) -> Void,
                tryLoadTransactions: @escaping () -> Void,
                balanceViewModel: PresentableBalanceViewModel,
                transactionListViewModel: TransactionListViewModel
    ) {
        self.publicKey = publicKey
        self.network = network
        self.currency = currency
        self.balanceLabelTitle =  balanceLabelTitle
        self.balanceLoadingTitle = balanceLoadingTitle
        self.balanceErrorMessage = balanceErrorMessage
        self.balanceErrorButtonTitle = balanceErrorButtonTitle
        self.transactionListTitle = transactionListTitle
        self.transactionListSubtitle = transactionListSubtitle
        self.transactionLoadingTitle = transactionLoadingTitle
        self.transactionErrorMessage = transactionErrorMessage
        self.transactionErrorButtonTitle = transactionErrorButtonTitle
        self.transactionSelection = transactionSelection
        self.tryLoadBalance = tryLoadBalance
        self.tryLoadTransactions = tryLoadTransactions
        self._balanceViewModel = State(initialValue: balanceViewModel)
        self._transactionListViewModel = State(initialValue: transactionListViewModel)
    }
    
    private let publicKey: String
    private let network: String
    private let currency: String
    private let balanceLabelTitle: String
    private let balanceLoadingTitle: String
    private let balanceErrorMessage: String
    private let balanceErrorButtonTitle: String
    private let transactionListTitle: String
    private let transactionListSubtitle: String
    private let transactionLoadingTitle: String
    private let transactionErrorMessage: String
    private let transactionErrorButtonTitle: String
    
    private let transactionSelection: (String) -> Void
    private let tryLoadBalance: (String?) -> Void
    private let tryLoadTransactions: () -> Void
    
    @State private var balanceViewModel: PresentableBalanceViewModel
    @State private var transactionListViewModel: TransactionListViewModel
    
    public var body: some View {
        VStack {
            HeaderView(
                title: publicKey,
                titleTextColor: .primary,
                subtitle: network,
                subtitleTextColor: .blue
            )
            
            BalanceView(
                title: "Balance:",
                currencyName: currency,
                loadingTitle: "Loading balance...",
                onTryAgain: { balanceViewModel.setLoading() },
                viewModel: balanceViewModel
            )
            
            TransactionListUIComposerView(
                currencyName: currency,
                errorMessage: "Cannot load transactions",
                errorViewButtonTitle: "Try again",
                loadingTitle: "Loading transactions...",
                tryAgain: { transactionListViewModel.setLoading() },
                selection: { transactionSelection($0) },
                viewModel: transactionListViewModel
            )
        }
    }
}



struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet UI Composer Test View")
        }
    }
}

struct WalletTestView: View {
    @State var selection = "none"
    
    var body: some View {
        VStack {
            WalletDetailView(publicKey: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                          network: "Solana Mainnet",
                          currency: "lamports",
                          balanceLabelTitle: "Balance:",
                          balanceLoadingTitle: "Loading balance",
                          balanceErrorMessage: "Cannot load balance",
                          balanceErrorButtonTitle: "Try again",
                          transactionListTitle: "Transaction List",
                          transactionListSubtitle: "Past transactions are stored here.",
                          transactionLoadingTitle: "Loading transactions",
                          transactionErrorMessage: "Cannot load transactions",
                          transactionErrorButtonTitle: "Try again",
                          transactionSelection: { selection = $0 },
                          tryLoadBalance: { selection = $0 ?? "" },
                          tryLoadTransactions: { },
                          balanceViewModel: .init(model: PresentableBalance(value: "10000000000.0000")),
                          transactionListViewModel: .init(model: [
                            PresentableTransaction(date: "Feb 25, 2023",
                                                   from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                   to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                   amount: "100000000.0000",
                                                   currencyName: "lamports",
                                                   signature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                            PresentableTransaction(date: "Feb 24, 2023",
                                                   from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                   to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                   amount: "200000000.0000",
                                                   currencyName: "lamports",
                                                   signature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn"),
                            PresentableTransaction(date: "Feb 23, 2023",
                                                   from: "CwdjgD54hgTQChspxHhirWLQWqy3EsxtndrcpLBqpump",
                                                   to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                   amount: "300000000.0000",
                                                   currencyName: "lamports",
                                                   signature: "ohQyPbDg48qkrwWgRzoQd1yN5Rsz6n22e9hkb89NK7U3QjifTuTK3zQptRZqpdkWePjqT45XJ5eaQviPHmakJwg")
                          ]))
            
            
            
            //                        Text("Last selection: " + selection).padding()
        }
    }
}


