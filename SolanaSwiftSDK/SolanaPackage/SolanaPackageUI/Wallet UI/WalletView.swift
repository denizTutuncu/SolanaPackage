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
    public let selection: (String) -> Void
    
    @State var walletViewModel: WalletViewModel
    @State var transactionViewModel: TransactionViewModel
    
    public init(balanceLabelTitle: String,
                currencyName: String,
                transactionListTitle: String,
                transactionListSubtitle: String,
                network: String,
                selection: @escaping (String) -> Void,
                walletStore: WalletViewModel,
                transactionStore: TransactionViewModel)
    {
        self.balanceLabelTitle = balanceLabelTitle
        self.currencyName = currencyName
        self.transactionListTitle = transactionListTitle
        self.transactionListSubtitle = transactionListSubtitle
        self.network = network
        self.selection = selection
        self.walletViewModel = walletStore
        self.transactionViewModel = transactionStore
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: walletViewModel.wallet?.publicKey,
                       subtitle: network)
            BalanceView(title: balanceLabelTitle,
                        currencyName: currencyName,
                        wallet: $walletViewModel.wallet)
            TransactionListView(title: transactionListTitle,
                                subtitle: transactionListSubtitle,
                                store: transactionViewModel,
                                selection: { transaction in
                selection(transaction.transactionSignature)
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
                       selection: { selection = $0 },
                       walletStore: .init(wallets: [WalletUI(id: UUID(), publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                             balance: "1000000000.0")],
                                          handler: { selection = $0.publicKey }),
                       transactionStore: .init(transactions: [
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


