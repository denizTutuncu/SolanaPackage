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
    
    private let sceneMaker = SceneMaker()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                sceneMaker.makeScene()
            }
        }
    }
}

public class SceneMaker {
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private func makeRemoteBalanceLoader(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: baseURL)
        return httpClient.getPublisher(urlRequest: request!).tryMap(BalanceItemMapper.map).eraseToAnyPublisher()
    }
  
    
    
    public func makeScene() -> AnyView {
        let balancePublisher = makeRemoteBalanceLoader(address: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", baseURL: URL(string: "https://api.devnet.solana.com")!)
        let walletViewModel = WalletViewModel()
        return AnyView(MainView(walletViewModel: walletViewModel))
    }
}


//        "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
//        URL(string: "https://api.devnet.solana.com")!
//return AnyView(BalanceContainerView(amount: "10000000", currencyName: "lamports", onHide: { print("On hide pressed") }) )


