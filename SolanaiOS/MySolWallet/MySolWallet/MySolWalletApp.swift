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
    var body: some Scene {
        WindowGroup {
            VStack {
                BalanceComposerView(viewModel:  BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: URL(string: SolanaClusterRPCEndpoints.devNet.rawValue), methodName: "getBalance", publicKey: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))))
                Spacer()
            }
           
        }
    }
}
