//
//  BalanceViewModel.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import Foundation
import Combine
import SwiftUI

public class BalanceViewModel: ObservableObject {
    
    public struct BalanceUIModel {
        public let balance: Balance?
        public let error: Error?
        public var isLoading: Bool
        init(balance: Balance?, error: Error?, isLoading: Bool = true) {
            self.balance = balance
            self.error = error
            self.isLoading = isLoading
        }
    }
    
    @Published public var uiModel: BalanceUIModel = BalanceUIModel(balance: nil, error: nil, isLoading: true)
    
    public var labelTitle: String {
        return NSLocalizedString("BALANCE_LABEL_TITLE",
                                 tableName: "Balance",
                                 bundle: Bundle(for: BalanceViewModel.self),
                                 comment: "Title for Label")
    }

    public var loadingTitle: String {
        return NSLocalizedString("BALANCE_LOADING_TITLE",
                                 tableName: "Balance",
                                 bundle: Bundle(for: BalanceViewModel.self),
                                 comment: "Title for Loading View")
    }
    
    private let remoteBalanceLoader: RemoteBalanceLoader
    public init(remoteBalanceLoader: RemoteBalanceLoader) {
        self.remoteBalanceLoader = remoteBalanceLoader
    }
    
    public func loadBalance() {        
        remoteBalanceLoader.load { [weak self] result in
            switch result {
            case let .success(balance):
                let balanceViewModel = BalanceUIModel(balance: balance, error: nil, isLoading: false)
                DispatchQueue.main.async {
                    self?.uiModel = balanceViewModel
                }
               
            case let .failure(error):
                print(error.localizedDescription)
                let balanceViewModel = BalanceUIModel(balance: nil, error: error, isLoading: false)
                DispatchQueue.main.async {
                    self?.uiModel = balanceViewModel
                }
            }
          
        }
    }
}
