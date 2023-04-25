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
    typealias PublicKeyStore = SolanaPackage.PublicKeyStore
    typealias PrivateKeyStore = SolanaPackage.PrivateKeyStore
    typealias SeedStore = SolanaPackage.SeedStore
    
    var bank: Bank?
    
    //MARK: - Seed & Seed Store & Local Seed Loader
    private let seed = BankOfSeed.seed
    
    private lazy var seedStore: SeedStore = {
        
        return HardcodedSeedStore(seed: seed)
    }()
    
    public lazy var localSeedLoader: LocalSeedLoader = {
        LocalSeedLoader(store: seedStore)
    }()
    
    
    public func makeLocalSeedPublisher() ->  AnyPublisher<[String], Error> {
        return localSeedLoader.getPublisher()
    }
    
    //MARK: - Public Key Store & Local Public Key Loader
    private lazy var publicKeyStore: PublicKeyStore = {
        do {
            return try CodablePublicKeyStore(storeURL: URL(string:  "com.deniztutuncu.MySolWallet")!)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
        
    }()
    
    private lazy var localPublicKeyLoader: LocalPublicKeyLoader = {
        LocalPublicKeyLoader(store: publicKeyStore, currentDate: Date.init)
    }()
    
    public func makeLocalPublicKeyPublisher() ->  AnyPublisher<[String], Error> {
        return localPublicKeyLoader.getPublisher()
    }
    
    //MARK: - Private Key Store & Local Private Key Loader
    private lazy var privateKeyStore: PrivateKeyStore = {
        return KeychainPrivateKeyStore(network: "com.deniztutuncu.MySolWallet")
    }()
    
    private lazy var localPrivateKeyLoader: LocalPrivateKeyLoader = {
        LocalPrivateKeyLoader(store: privateKeyStore)
    }()
    
    //MARK: - Network URL & Http Client & Balance Loader & Balance Publisher
    private lazy var networkURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    public func makeRemoteBalancePublisher(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
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
        let adapter = iOSSwiftUINavigationAdapter(navigation: navigationStore,
                                                  publicKeyPublisher:  appStore.makeLocalPublicKeyPublisher(),
                                                  seedPublisher: appStore.makeLocalSeedPublisher(),
                                                  createWallet: { seed in },
                                                  selectPublicKey: { keys in })
        
        appStore.bank = Bank.start(publicKeysDelegate: adapter,
                                   publicKeys: [],
                                   seedDelegate: adapter,
                                   seed: [])
    }
}   
