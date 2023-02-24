//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import os
import SwiftUI
import SolanaPackage
import SolanaPackageUI
import Combine

class BankAppStore {
    var bank: Bank?
    
    private lazy var baseURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")
    
    private lazy var store: WalletStore = {
        return KeychainWalletStore(key: "com.deniztutuncu.MySolWallet")
    }()
    
    private lazy var localWalletLoader: LocalWalletLoader = {
        LocalWalletLoader(store: store, currentDate: Date.init)
    }()
    
    private lazy var seeds: [String] = {
        return []
    }()
    
    private func makeRemoteBalancePublisher(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: baseURL)
        return httpClient
            .getPublisher(urlRequest: request!)
            .tryMap(BalanceItemMapper.map)
            .eraseToAnyPublisher()
    }
    
}

@main
struct MySolWalletApp: App {
    let appStore = BankAppStore()
    @StateObject var navigationStore = BankNavigationStore()
    
    var body: some Scene {
        WindowGroup {
            BankNavigationView(store: navigationStore)
                .onAppear{ startBank() }
        }
    }
    
    private func startBank() {
   
//        let adapter = iOSSwiftUINavigationAdapter(navigation: navigationStore,
//                                                  wallets: <#T##iOSSwiftUINavigationAdapter.Wallets#>,
//                                                  seed: <#T##iOSSwiftUINavigationAdapter.Seed#>,
//                                                  loadAgain: startBank)
//
//        appStore.bank = Bank.start(wallets: <#T##[String]#>, walletLoader: <#T##LocalWalletLoader#>, delegate: <#T##WalletDelegate#>, seeds: <#T##[String]#>)
    }
    
}
