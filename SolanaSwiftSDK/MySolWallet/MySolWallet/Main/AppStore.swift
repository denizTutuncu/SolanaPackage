
//  AppStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/30/23.


import Foundation
import SolanaPackage
import SolanaPackageUI
import Combine
import os
import SolanaSwift

class AppStore {
    typealias PublicKey = LocalPublicKeyLoader.PublicKey
    typealias PrivateKeyLoaderPublicKey = LocalPrivateKeyLoader.PublicKey
    typealias PrivateKey = LocalPrivateKeyLoader.PrivateKey
    typealias Seed = LocalSeedLoader.Seed
    
    typealias PublicKeyStore = SolanaPackage.PublicKeyStore
    typealias PrivateKeyStore = SolanaPackage.PrivateKeyStore
    typealias SeedStore = SolanaPackage.SeedStore
    
    typealias WalletCreator = SolanaPackage.WalletCreator
        
    //MARK: - Logger
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")
    
    private func handleError(_ error: Error) {
          logger.fault("Failed to instantiate with error: \(error.localizedDescription)")
      }
    
    //MARK: - Scheduler
    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "com.denizTutuncu.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()
    
    //MARK: - Seed & Seed Store & Local Seed Loader
    private let seed = BankOfSeed.seed
    
    private lazy var seedStore: SeedStore = {
        return HardcodedSeedStore(seed: seed)
    }()
    
    public lazy var localSeedLoader: LocalSeedLoader = {
        LocalSeedLoader(store: seedStore)
    }()
    
    public func makeLocalSeedPublisher() ->  AnyPublisher<Seed, Error> {
        return localSeedLoader.getPublisher()
    }
    
    //MARK: - Wallet Creator & Local Wallet Creator
    public lazy var walletCreator: WalletCreator = {
        do {
            return try SolanaWalletCreator(loader: localSeedLoader)
        } catch {
            assertionFailure("Failed to instantiate Wallet Creator with error: \(error.localizedDescription)")
            handleError(error)
            return NullCreator()
        }
    }()
    
    public lazy var localWalletCreator: LocalWalletCreator = {
        LocalWalletCreator(creator: walletCreator)
    }()
        
    //MARK: - Private Key Store & Local Private Key Loader
    private lazy var privateKeyStore: PrivateKeyStore = {
        return KeychainPrivateKeyStore()
    }()
    
    private lazy var localPrivateKeyLoader: LocalPrivateKeyLoader = {
        LocalPrivateKeyLoader(store: privateKeyStore)
    }()
    
    public func makeLocalPrivateKeyPublisher(from: PrivateKeyLoaderPublicKey) ->  AnyPublisher<PrivateKey?, Error> {
        return localPrivateKeyLoader.loadPrivateKeyPublisher(from)
    }
    
    //MARK: - Network URL & Http Client & Balance Loader & Balance Publisher
    private lazy var networkURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    //MARK: - Public Key Store & Local Public Key Loader & Local Public Key Publisher
    private lazy var publicKeyStore: PublicKeyStore = {
        do {
            return try CodablePublicKeyStore(storeURL: URL(string:  "com.deniztutuncu.MySolWallet")!)
        } catch {
            assertionFailure("Failed to instantiate Codable store with error: \(error.localizedDescription)")
            handleError(error)
            return NullStore()
        }
    }()
    
    private lazy var localPublicKeyLoader: LocalPublicKeyLoader = {
        LocalPublicKeyLoader(store: publicKeyStore, currentDate: Date.init)
    }()
    
    private func makeLocalPublicKeyPublisher() ->  AnyPublisher<[PublicKey], Error> {
        return localPublicKeyLoader.getPublisher()
    }
    
    //MARK: - Transactions Publisher
    private func makeRemoteBalancePublisher(address: PublicKey) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: networkURL)
        return httpClient
            .getPublisher(urlRequest: request!)
            .tryMap(BalanceItemMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func makeRemoteTransactionPublisher(address: PublicKey) -> AnyPublisher<[DomainTransaction], Error> {
        let request = try? TransactionEndpoint.get(publicKey: address).url(baseURL: networkURL)
        return httpClient
            .getPublisher(urlRequest: request!)
            .tryMap(TransactionItemMapper.map)
            .eraseToAnyPublisher()
    }
    
    public func fetchPresentablePublicKeys() -> AnyPublisher<[PresentablePublicKey], Error> {
        makeLocalPublicKeyPublisher()
            .tryMap { domainPublicKeys in
                PublicKeyStoreMapper.map(domainPublicKeys)
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchPresentableBalance(for address: PublicKey) -> AnyPublisher<PresentableBalance, Error> {
        makeRemoteBalancePublisher(address: address)
            .tryMap { domainBalance in
                try BalanceStoreMapper.map(domainBalance)
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchPresentableSeeds() -> AnyPublisher<[PresentableSeed], Error> {
        makeLocalSeedPublisher()
            .tryMap { domainSeed in
                try SeedStoreMapper.map(domainSeed)
            }
            .eraseToAnyPublisher()
    }

    public func fetchTransactions(for address: PublicKey) -> AnyPublisher<[PresentableTransaction], Error> {
        makeRemoteTransactionPublisher(address: address)
            .map { domainTransactions in
                TransactionStoreMapper.map(domainTransactions)
            }
            .eraseToAnyPublisher()
    }
    
    public func createWallet(from seed: Seed) -> AnyPublisher<Void, Error> {
        
    }
}
