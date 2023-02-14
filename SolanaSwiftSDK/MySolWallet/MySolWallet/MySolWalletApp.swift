//
//  MySolWalletApp.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import SwiftUI
import SolanaPackage
import SolanaPackageUI
import Combine

@main
struct MySolWalletApp: App {
    private let composer = MainView()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                composer.mainView()
            }
        }
    }
}

public class FlowView {
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var baseURL: URL = {
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
    
    private lazy var walletAccountAddress: String = {
        "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
    }()
    
    private lazy var balancePublisher: AnyPublisher<Balance, Error> = {
        makeRemoteBalancePublisher(address: walletAccountAddress, baseURL: baseURL)
    }()
    
    private func balanceView(balance: String = "0") -> AnyView {
        AnyView(Color.blue)
//        AnyView(BalanceContainerView(result: .success(balance), title: BalancePresenter.title, currencyName: "SOL", progress: 0.7, total: 1.0, onHide: {}))
    }
    
    private lazy var createWalletView: AnyView = {
        AnyView(
            Button(action: {
                
            }, label: {
                Text("Create Wallet").padding()
            }))
    }()
    
    public func mainView() -> AnyView {
        var newPublisher: PublisherViewModel<Balance, BalanceViewModel>?
        balancePublisher.sink { _ in } receiveValue: { balance in
            print("Balance is \(balance). Total lamports are \(balance.amount)")
            let publisher = PublisherViewModel(resource: balance, mapper: BalanceViewModelMapper.map)
            publisher.loadResource()
            newPublisher = publisher
        }
        .store(in: &cancellables)
        
        return AnyView(MainView(hasWallet: .constant(true), mainContainer: { self.balanceView(balance: newPublisher?.onResourceLoad?.amount ?? "0") }, createWalletContainer: { self.createWalletView } ))
    }
    
}
