////
////  GetBalanceViewModel.swift
////  SolanaPackageUI
////
////  Created by Deniz Tutuncu on 4/26/22.
////
//
//import Foundation
//import Combine
//import SolanaPackage
//
//public final class GetBalanceViewModel: ObservableObject {
//    private let loader: BalanceLoader
//    private let pubKey: String
//    
//    @Published var model: UIUserModel?
//    
//    public init(loader: BalanceLoader, pubKey: String) {
//        self.loader = loader
//        self.pubKey = pubKey
//    }
//    
//    public func loadBalance() {
//        loader.perform(pubKey: pubKey) { [weak self] result in
//            guard self != nil else { return }
//            switch result {
//            case let .success(getBalanceResponse):
//                print(getBalanceResponse)
//                
//                let userModel = UIUserModel(walletAddress: self?.model?.walletAddress ?? "No wallet address", balance: "\(getBalanceResponse.result.value)")
//                self?.model = userModel
//              
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//}
