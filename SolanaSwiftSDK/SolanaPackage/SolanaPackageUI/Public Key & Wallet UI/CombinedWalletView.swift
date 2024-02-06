//
//  WalletView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import SwiftUI

public struct CombinedWalletView: View {
    public let publicKey: String
    public let network: String
    public let currency: String
    public let balanceLabelTitle: String
    public let balanceLoadingTitle: String
    public let balanceErrorMessage: String
    public let balanceErrorButtonTitle: String
    public let transactionListTitle: String
    public let transactionListSubtitle: String
    public let transactionLoadingTitle: String
    public let transactionErrorMessage: String
    public let transactionErrorButtonTitle: String
    public let transactionSelection: (String) -> Void
    public let tryLoadBalance: (String?) -> Void
    public let tryLoadTransactions: () -> Void
    
    @State public var balanceLoading: Bool
    @State public var balanceViewModel: BalanceViewModel
    @State public var transactionViewModel: TransactionViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: publicKey,
                       subtitle: network)
            
            BalanceUIComposer(title: balanceLabelTitle,
                              currencyName: currency,
                              errorMessage: balanceErrorMessage,
                              errorButtonTitle: balanceErrorButtonTitle,
                              loadingTitle: balanceLoadingTitle,
                              tryAgain: { tryLoadBalance(publicKey); balanceLoading = true },
                              viewModel:  balanceViewModel,
                              loading: $balanceLoading)
            
            HeaderView(title: transactionListTitle, subtitle: transactionListSubtitle)
            
            TransactionListUIComposerView(currencyName: currency,
                                          errorMessage: transactionErrorMessage,
                                          errorViewButtonTitle: transactionErrorButtonTitle,
                                          loadingTitle: transactionLoadingTitle,
                                          tryAgain: tryLoadTransactions,
                                          selection: transactionSelection,
                                          viewModel: transactionViewModel)
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
            CombinedWalletView(publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
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
                                 balanceLoading: false,
                                 balanceViewModel: .init(model: PresentableBalance(value: "10000000000.0000")),
                                 transactionViewModel: .init(model: [
                                    PresentableTransaction(date: "Feb 23, 2023",
                                                           from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                           to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                           amount: "100000000.0000",
                                                           currencyName: "lamports",
                                                           signature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                    PresentableTransaction(date: "Feb 24, 2023",
                                                           from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                           to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                           amount: "200000000.0000",
                                                           currencyName: "lamports",
                                                           signature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn"),
                                    PresentableTransaction(date: "Feb 25, 2023",
                                                           from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                           to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                           amount: "300000000.0000",
                                                           currencyName: "lamports",
                                                           signature: "ohQyPbDg48qkrwWgRzoQd1yN5Rsz6n22e9hkb89NK7U3QjifTuTK3zQptRZqpdkWePjqT45XJ5eaQviPHmakJwg")
                                 ]))
            
            
            
            //                        Text("Last selection: " + selection).padding()
        }
    }
}


