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
    typealias KCWalletStore = SolanaPackage.CredentialsStore
    typealias Seed = SolanaPackage.DomainSeed
    
    var bank: Bank?
    
    private lazy var baseURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")
    
    //MARK: - Keychain Wallet Store & Local Wallet Loader
    public lazy var kcStore: KCWalletStore = {
        return KeychainPrivateKeyStore(network: "com.deniztutuncu.MySolWallet")
    }()
    
    private lazy var keychainWalletLoader: LocalCredentialsLoader = {
        LocalCredentialsLoader(store: kcStore)
    }()
    
    //MARK: - Seed Store & Local Seed Loader
//    private lazy var seedStore: LocalSeedStore {
//        do {
//            return try CoreDataWalletStore(
//                storeURL: NSPersistentContainer
//                    .defaultDirectoryURL()
//                    .appendingPathComponent("seed-store.sqlite"))
//        } catch {
//            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
//            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
//            return NullStore()
//        }
//    }()
    
//    private lazy var seedLoader: SeedLoader = {
//        SeedLoader(store: seedStore, currentDate: Date.init)
//    }()
    
    public lazy var duumySeed: Seed = {
        return Seed(id: UUID(), seed: [
            "private","digital","coin","seed","key","has","very","long",
            "secret","pass","phrase","that","will","prevent","animal","weasel",
            "brain","person","like","you","obtain","any","large","wealth",
           ])
    }()
    
    //MARK: - Balance Publisher
    private func makeRemoteBalancePublisher(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: baseURL)
        return httpClient
            .getPublisher(urlRequest: request!)
            .tryMap(BalanceItemMapper.map)
            .eraseToAnyPublisher()
    }
    
//    private func makePrivateKeyPublisher() -> AnyPublisher<DomainWallet, Error> {
//        return keychainWalletLoader
//            .load(for: <#T##KeychainWallet?#>)
//    }
    
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
                                                  wallets: [],
                                                  seed: appStore.duumySeed,
                                                  loadAgain: startBank)
        
        
        appStore.bank = Bank.start(delegate: adapter, wallets: [], seed: appStore.duumySeed)
    }
}
