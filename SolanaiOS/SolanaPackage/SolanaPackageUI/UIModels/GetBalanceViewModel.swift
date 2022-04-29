//
//  GetBalanceViewModel.swift
//  SolanaPackageUI
//
//  Created by Deniz Tutuncu on 4/26/22.
//

import Foundation
import Combine
import SolanaPackage

public final class GetBalanceViewModel: ObservableObject {
    private let loader: GetBalanceLoader
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var model: UIUserModel?
    
    public init(loader: GetBalanceLoader) {
        self.loader = loader
    }
    
    public func loadBalance(pubKey: String?) {
        loader.perform(pubKey: pubKey) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(getBalanceResponse):
                print(getBalanceResponse)
                
                let userModel = UIUserModel(walletAddress: self?.model?.walletAddress ?? "No wallet address", balance: "\(getBalanceResponse.result.value)")
                self?.model = userModel
              
            case let .failure(error):
                print(error)
            }
        }
    }
}
