//
//  WalletView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import SwiftUI

public struct WalletView: View {
    public let balanceLabelTitle: String
    public let currencyName: String
    public let transactionListTitle: String
    public let transactionListSubtitle: String
    public let network: String
    public let transactionSelection: (String) -> Void
    
    @State var walletViewModel: WalletViewModel
    @State var transactionViewModel: TransactionViewModel
    
    public init(balanceLabelTitle: String,
                currencyName: String,
                transactionListTitle: String,
                transactionListSubtitle: String,
                network: String,
                transactionSelection: @escaping (String) -> Void,
                walletViewModel: WalletViewModel,
                transactionViewModel: TransactionViewModel)
    {
        self.balanceLabelTitle = balanceLabelTitle
        self.currencyName = currencyName
        self.transactionListTitle = transactionListTitle
        self.transactionListSubtitle = transactionListSubtitle
        self.network = network
        self.transactionSelection = transactionSelection
        self.walletViewModel = walletViewModel
        self.transactionViewModel = transactionViewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: walletViewModel.wallet?.id,
                       subtitle: network)
            BalanceView(title: balanceLabelTitle,
                        currencyName: currencyName,
                        wallet: $walletViewModel.wallet)
            TransactionListView(title: transactionListTitle,
                                subtitle: transactionListSubtitle,
                                store: transactionViewModel,
                                selection: { transaction in
                transactionSelection(transaction.transactionSignature)
            })
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletTestView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Wallet Test View")
        }
    }
}

struct WalletTestView: View {
    @State var selection = "none"
    
    var body: some View {
        VStack {
            WalletView(balanceLabelTitle: "Balance",
                       currencyName: "lamports",
                       transactionListTitle: "Transaction List",
                       transactionListSubtitle: "Past transactions are stored here.",
                       network: "Solana",
                       transactionSelection: { selection = $0 },
                       walletViewModel: .init(wallets: [WalletUI(id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                             balance: "1000000000.0")],
                                          handler: { selection = $0.id }),
                       transactionViewModel: .init(transactions: [
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
                                                                            transactionSignature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn"),
                        TransactionUI(date: "Feb 25, 2023",
                                                                            from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                                            to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                                            amount: "30000000000.00",
                                                                            currencyName: "lamports",
                                                                            transactionSignature: "ohQyPbDg48qkrwWgRzoQd1yN5Rsz6n22e9hkb89NK7U3QjifTuTK3zQptRZqpdkWePjqT45XJ5eaQviPHmakJwg")
                       ]))
            
            Text("Last selection: " + selection).padding()
        }
    }
}


