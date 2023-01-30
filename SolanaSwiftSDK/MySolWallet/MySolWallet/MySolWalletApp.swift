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
    
    private let mainFlow = MainUIComposer()

    var body: some Scene {
        WindowGroup {
            VStack {
                mainFlow.makeFirstPage()
            }
        }
    }
}

public class MainUIComposer {
    private lazy var baseURL: URL = {
        URL(string: "https://api.devnet.solana.com")!
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private func makeRemoteBalanceLoader(address: String, baseURL: URL) -> AnyPublisher<Balance, Error> {
        let request = try? BalanceEndpoint.get(walletAddress: address).url(baseURL: baseURL)
        return httpClient.getPublisher(urlRequest: request!).tryMap(BalanceItemMapper.map).eraseToAnyPublisher()
    }
    
    public func makeFirstPage() -> AnyView {
        let balancePublisher = makeRemoteBalanceLoader(address: "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi", baseURL: baseURL)
        
        return AnyView(MainView(hasWallet: .constant(true)))
    }
}
