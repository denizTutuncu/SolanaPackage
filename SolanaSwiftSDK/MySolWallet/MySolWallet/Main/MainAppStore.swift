//
//  MainAppStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/30/23.
//

import Foundation
import SolanaPackage
import Combine
import os

class MainAppStore {
    typealias PublicKey = String
    typealias PublicKeyStore = SolanaPackage.PublicKeyStore
    typealias PrivateKeyStore = SolanaPackage.PrivateKeyStore
    typealias SeedStore = SolanaPackage.SeedStore
    typealias WalletCreator = SolanaPackage.WalletCreator
    
    var mainApp: MainApp?
    
    //MARK: - Logger
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")
    
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
    
    public func makeLocalSeedPublisher() ->  AnyPublisher<[String], Error> {
        return localSeedLoader.getPublisher()
    }
    
    //MARK: - Wallet Creator & Local Wallet Creator
    public lazy var walletCreator: WalletCreator = {
        do {
            return try DummyWalletCreator(seed: [])
        } catch {
            assertionFailure("Failed to instantiate Wallet Creator with error: \(error.localizedDescription)")
            logger.fault("Failed to instantiate  allet Creator store with error: \(error.localizedDescription)")
            return NullCreator()
        }
    }()
    
    public lazy var localWalletCreator: LocalWalletCreationLoader = {
        LocalWalletCreationLoader(creator: walletCreator)
    }()
    
    //MARK: - Private Key Store & Local Private Key Loader
    private lazy var privateKeyStore: PrivateKeyStore = {
        return KeychainPrivateKeyStore()
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

    //MARK: - Public Key Store & Local Public Key Loader
    private lazy var publicKeyStore: PublicKeyStore = {
        do {
            return try CodablePublicKeyStore(storeURL: URL(string:  "com.deniztutuncu.MySolWallet")!)
        } catch {
            assertionFailure("Failed to instantiate Codable store with error: \(error.localizedDescription)")
            logger.fault("Failed to instantiate Codable store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()
    
    private lazy var localPublicKeyLoader: LocalPublicKeyLoader = {
        LocalPublicKeyLoader(store: publicKeyStore, currentDate: Date.init)
    }()
    
    public func makeLocalPublicKeyPublisher() ->  AnyPublisher<[String], Error> {
        return localPublicKeyLoader.getPublisher()
    }
    
    //MARK: - Paginated
    public func makeLocalPublicKeyLoaderWithLocalFallback() -> AnyPublisher<Paginated<PublicKey>, Error> {
        makeLocalPublicKeyLoader()
            .caching(to: localPublicKeyLoader)
            .fallback(to: localPublicKeyLoader.getPublisher)
            .map(makeFirstPage)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    private func makeLocalLoadMoreLoader(last: PublicKey?) -> AnyPublisher<Paginated<PublicKey>, Error> {
        localPublicKeyLoader.getPublisher()
            .zip(makeLocalPublicKeyLoader(after: last))
            .map { (cachedItems, newItems) in
                (cachedItems + newItems, newItems.last)
            }
            .map(makePage)
            .caching(to: localPublicKeyLoader)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    private func makeLocalPublicKeyLoader(after: PublicKey? = nil) -> AnyPublisher<[PublicKey], Error> {
        return makeLocalPublicKeyPublisher()
            .tryMap(PublicKeyItemsMapper.map)
            .eraseToAnyPublisher()
    }
    
    //MARK: First Page
    private func makeFirstPage(items: [PublicKey]) -> Paginated<PublicKey> {
        makePage(items: items, last: items.last)
    }
    
    private func makePage(items: [PublicKey], last: PublicKey?) -> Paginated<PublicKey> {
        Paginated(items: items, loadMorePublisher: last.map { last in
            { self.makeLocalLoadMoreLoader(last: last) }
        })
    }
}
