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
    
    private var balanceLoadError: String {
        return NSLocalizedString("BALANCE_VIEW_CONNECTION_ERROR",
                                 tableName: "Balance",
                                 bundle: Bundle(for: BalanceViewModel.self),
                                 comment: "Error message displayed when we can't load the balance from the server")
    }
    
    public static var title: String {
        return NSLocalizedString("BALANCE_VIEW_TITLE", tableName: "Balance", bundle: Bundle(for: BalanceViewModel.self), comment: "Title for the balance view")
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
                let balanceViewModel = BalanceUIModel(balance: nil, error: error, isLoading: false)
                DispatchQueue.main.async {
                    self?.uiModel = balanceViewModel
                }
            }
          
        }
    }
}
