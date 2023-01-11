//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI

@main
struct MySolWalletApp: App {
    let remoteBalanceLoader = RemoteBalanceLoader(url: URL(string: BalanceEndpoint.devNet.rawValue),
                                                  publicAddress: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi",
                                                  client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))
    var body: some Scene {
        WindowGroup {
            VStack {
                BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: remoteBalanceLoader))
                Spacer()
            }
        }
    }
}
