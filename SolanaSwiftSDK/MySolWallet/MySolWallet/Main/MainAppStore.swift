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
import SolanaSwift

class MainAppStore {
    typealias PublicKey = String
    typealias PublicKeyStore = SolanaPackage.PublicKeyStore
    typealias PrivateKeyStore = SolanaPackage.PrivateKeyStore
    typealias SeedStore = SolanaPackage.SeedStore
    typealias WalletCreator = SolanaPackage.WalletCreator
    
    var mainApp: MainApp?
    
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
    
    public func makeLocalSeedPublisher() ->  AnyPublisher<[String], Error> {
        return localSeedLoader.getPublisher()
    }
    
    //MARK: - Wallet Creator & Local Wallet Creator
    public lazy var walletCreator: WalletCreator = {
        do {
            return try MainWalletCreator(seed: try localSeedLoader.load(), loader: localSeedLoader)
        } catch {
            assertionFailure("Failed to instantiate Wallet Creator with error: \(error.localizedDescription)")
            handleError(error)
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
            handleError(error)
            return NullStore()
        }
    }()
    
    private lazy var localPublicKeyLoader: LocalPublicKeyLoader = {
        LocalPublicKeyLoader(store: publicKeyStore, currentDate: Date.init)
    }()
    
    public func makeLocalPublicKeyPublisher() ->  AnyPublisher<[String], Error> {
        return localPublicKeyLoader.getPublisher()
    }
}
