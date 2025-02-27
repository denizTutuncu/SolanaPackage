//
//  AppStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/30/23.
//

import Foundation
import SolanaPackage
import SolanaPackageUI
import Combine
import os
import SolanaSwift

class AppStore: ObservableObject {
    typealias PublicKey = LocalPublicKeyLoader.PublicKey
    typealias PrivateKeyLoaderPublicKey = LocalPrivateKeyLoader.PublicKey
    typealias PrivateKey = LocalPrivateKeyLoader.PrivateKey
    typealias Seed = LocalSeedLoader.Seed
    
    typealias PublicKeyStore = SolanaPackage.PublicKeyStore
    typealias PrivateKeyStore = SolanaPackage.PrivateKeyStore
    typealias SeedStore = SolanaPackage.SeedStore
    typealias WalletCreator = SolanaPackage.WalletCreator
    
    // MARK: - Logger
    private lazy var logger = Logger(subsystem: "com.deniztutuncu.MySolWallet", category: "main")

    private func handleError(_ error: Error) {
        logger.fault("Error: \(error.localizedDescription)")
    }

    // MARK: - Published State Variables
    @Published var selectedPublicKey: PublicKey?
    @Published var presentablePublicKeys: [PresentablePublicKey] = []
    @Published var presentableBalance: PresentableBalance?
    @Published var presentableTransactions: [PresentableTransaction] = []

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Dependencies
    private let networkURL: URL
    private let httpClient: HTTPClient
    private let localSeedLoader: LocalSeedLoader
    private let localPrivateKeyLoader: LocalPrivateKeyLoader
    private let localPublicKeyLoader: LocalPublicKeyLoader
    private let walletCreator: WalletCreator

    // MARK: - Initializer (Dependency Injection)
    init(
        networkURL: URL = URL(string: "https://api.devnet.solana.com")!,
        httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)),
        localSeedLoader: LocalSeedLoader = LocalSeedLoader(store: HardcodedSeedStore(seed: BankOfSeed.seed)),
        localPrivateKeyLoader: LocalPrivateKeyLoader = LocalPrivateKeyLoader(store: KeychainPrivateKeyStore()),
        localPublicKeyLoader: LocalPublicKeyLoader = {
            do {
                return LocalPublicKeyLoader(
                    store: try CodablePublicKeyStore(storeURL: URL(string: "com.deniztutuncu.MySolWallet")!),
                    currentDate: Date.init
                )
            } catch {
                assertionFailure("Failed to instantiate Codable store with error: \(error.localizedDescription)")
                return LocalPublicKeyLoader(store: NullStore(), currentDate: Date.init)
            }
        }()
    ) {
        self.networkURL = networkURL
        self.httpClient = httpClient
        self.localSeedLoader = localSeedLoader
        self.localPrivateKeyLoader = localPrivateKeyLoader
        self.localPublicKeyLoader = localPublicKeyLoader

        // ✅ Initialize walletCreator safely and log errors later
        var walletError: Error?
        do {
            self.walletCreator = try SolanaWalletCreator(loader: localSeedLoader)
        } catch {
            walletError = error
            self.walletCreator = NullCreator()
        }

        // ✅ Now it's safe to log errors after all properties are initialized
        if let error = walletError {
            handleError(error)
        }

        setupBindings()
        
        fetchPresentableSeeds()
            .sink(receiveCompletion: { _ in }, receiveValue: { seeds in
                print("🎯 Initial Seeds Loaded: \(seeds)")
            })
            .store(in: &cancellables)
    }

    // MARK: - Bindings for UI Updates
    private func setupBindings() {
        $selectedPublicKey
            .compactMap { $0 }
            .removeDuplicates()
            .flatMap { publicKey in
                self.fetchTransactions(for: publicKey)
                    .catch { _ in Just([]) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$presentableTransactions)

        $selectedPublicKey
            .compactMap { $0 }
            .removeDuplicates()
            .flatMap { publicKey in
                self.fetchPresentableBalance(for: publicKey)
                    .catch { _ in Just(PresentableBalance(value: "0")) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance in
                self?.presentableBalance = balance
            }
            .store(in: &cancellables)
    }

    // MARK: - API Publishers
    private func makeRemoteBalancePublisher(for address: PublicKey) -> AnyPublisher<Balance, Error> {
        guard let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: networkURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return httpClient.getPublisher(urlRequest: request)
            .tryMap(BalanceItemMapper.map)
            .eraseToAnyPublisher()
    }

    private func makeRemoteTransactionPublisher(for address: PublicKey) -> AnyPublisher<[DomainTransaction], Error> {
        guard let request = try? TransactionEndpoint.get(publicKey: address).url(baseURL: networkURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return httpClient.getPublisher(urlRequest: request)
            .tryMap(TransactionItemMapper.map)
            .eraseToAnyPublisher()
    }

    // MARK: - Fetching Methods
    public func fetchPresentablePublicKeys() -> AnyPublisher<[PresentablePublicKey], Error> {
        localPublicKeyLoader.getPublisher()
            .map(PublicKeyStoreMapper.map)
            .catch { _ in Just([]).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }

    public func fetchPresentableBalance(for address: PublicKey) -> AnyPublisher<PresentableBalance, Error> {
        makeRemoteBalancePublisher(for: address)
            .map { BalanceStoreMapper.map($0) ?? PresentableBalance(value: "0") }
            .catch { _ in Just(PresentableBalance(value: "0")).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }

    public func fetchPresentableSeeds() -> AnyPublisher<[String], Error> {
        localSeedLoader.getPublisher()
            .tryMap(SeedStoreMapper.map)
            .map { $0.map { $0.value } }
            .catch { _ in Just([]).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }

    public func fetchTransactions(for address: PublicKey) -> AnyPublisher<[PresentableTransaction], Error> {
        makeRemoteTransactionPublisher(for: address)
            .map(TransactionStoreMapper.map)
            .catch { _ in Just([]).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }
}

