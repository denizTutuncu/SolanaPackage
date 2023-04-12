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
    typealias CredentialsStore = SolanaPackage.PrivateKeyStore
    typealias Seed = SolanaPackage.DomainSeed
    typealias SeedStore = SolanaPackage.SeedBankStore
    
    var bank: Bank?
    
    //MARK: - Seed & Seed Store & Local Seed Loader
    private let seed = BankOfSeed.seed
    
    private lazy var seedStore: SeedStore = {
        return HardcodedSeedStore(seed: seed)
    }()
    
    public lazy var localSeedLoader: LocalSeedLoader = {
        LocalSeedLoader(store: seedStore)
    }()
    
    //MARK: - Credentials Store & Local Credentials Loader
    private lazy var credentialsStore: CredentialsStore = {
        return KeychainPrivateKeyStore(network: "com.deniztutuncu.MySolWallet")
    }()
    
    private lazy var localCredentialsLoader: LocalPrivateKeyLoader = {
        LocalPrivateKeyLoader(store: credentialsStore)
    }()
    
    //MARK: - Network URL & Http Client & Balance Loader & Balance Publisher
    private lazy var networkURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private func makeRemoteBalancePublisher(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: baseURL)
        return httpClient
            .getPublisher(urlRequest: request!)
            .tryMap(BalanceItemMapper.map)
            .eraseToAnyPublisher()
    }
    
    //MARK: - Logger
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")
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
        let seed = try! appStore.localSeedLoader.load()
        //        let wallets = try! appStore.localWalletLoader.load()
        
        print("\(seed) from MySolWalletApp")
        let adapter = iOSSwiftUINavigationAdapter(navigation: navigationStore,
                                                  wallets: [],
                                                  seed: seed,
                                                  loadAgain: startBank)
        
        
        appStore.bank = Bank.start(walletDelegate: adapter, wallets: [], seedDelegate: adapter, seed: seed)
    }
}   
