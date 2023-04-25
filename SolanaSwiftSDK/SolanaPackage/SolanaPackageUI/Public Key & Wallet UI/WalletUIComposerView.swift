//
//  WalletView.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import SwiftUI

public struct WalletUIComposerView: View {
    public let balanceLabelTitle: String
    public let currencyName: String
    public let transactionListTitle: String
    public let transactionListSubtitle: String
    public let network: String
    public let currency: String
    public let errorMessage: String
    public let downloadingTitle: String
    public let transactionSelection: (PresentableTransaction) -> Void
    public let tryAgain: () -> Void
    
    @State public var balanceViewModel: BalanceViewModel
    @State public var publicKeyViewModel: PublicKeyViewModel
    @State public var transactionViewModel: TransactionViewModel
    
    public var body: some View {
        VStack {
            HeaderView(title: publicKeyViewModel.publicKey?.id,
                       subtitle: network)
            
            BalanceUIComposer(title: balanceLabelTitle,
                              currencyName: currencyName,
                              errorMessage: errorMessage,
                              downloadingTitle: downloadingTitle,
                              tryAgain: tryAgain,
                              onLoadingState: balanceViewModel.onLoadingState,
                              viewModel:  balanceViewModel.balance.value)
            
            HeaderView(title: transactionListTitle, subtitle: transactionListSubtitle)
            
            TransactionUIComposerView(currencyName: currency,
                                      errorMessage: errorMessage,
                                      downloadingTitle: downloadingTitle,
                                      tryAgain: tryAgain,
                                      selection: transactionSelection,
                                      onLoadingState: transactionViewModel.onLoadingState,
                                      viewModel: transactionViewModel)
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
            WalletUIComposerView(balanceLabelTitle: "Balance:",
                               currencyName: "lamports",
                               transactionListTitle: "Transaction List",
                               transactionListSubtitle: "Past transactions are stored here.",
                               network: "Solana",
                               currency: "lamports",
                               errorMessage: "Downloading balance",
                               downloadingTitle: "Cannot connect to network",
                               transactionSelection: { selection = $0.transactionSignature },
                               tryAgain: { },
                               balanceViewModel: .init(balance: PresentableBalance(value: "10000000000.0000")),
                               publicKeyViewModel: .init(publicKeys: [PresentablePublicKey(id: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi")],
                                                         handler: { selection = $0.id }),
                               transactionViewModel: .init(transactions: [
                                PresentableTransaction(date: "Feb 23, 2023",
                                                       from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                       amount: "100000000.0000",
                                                       currencyName: "lamports",
                                                       transactionSignature: "5U3XaN8ab9mFWH47spgpE53jfFvCLeADBLdRDzfMt3yAsPDZBs3yWaSL58w6E83pquutbJA8CpsAGXAWmbNaCWaN"),
                                PresentableTransaction(date: "Feb 24, 2023",
                                                       from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                       amount: "200000000.0000",
                                                       currencyName: "lamports",
                                                       transactionSignature: "M5XeYGt6NFzD7RRKaAGbD4PCh2fdcSe246EnQURKFsntsYjCwWuD4ptwdoGo6iJ76u8PfRcevbCXegRzaahanCn"),
                                PresentableTransaction(date: "Feb 25, 2023",
                                                       from: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                       to: "3xcawfQtZVjRLLcxgcxT7yYUuynPlasdyqw640276bAD",
                                                       amount: "300000000.0000",
                                                       currencyName: "lamports",
                                                       transactionSignature: "ohQyPbDg48qkrwWgRzoQd1yN5Rsz6n22e9hkb89NK7U3QjifTuTK3zQptRZqpdkWePjqT45XJ5eaQviPHmakJwg")
                               ]))
            
            Text("Last selection: " + selection).padding()
        }
    }
}


