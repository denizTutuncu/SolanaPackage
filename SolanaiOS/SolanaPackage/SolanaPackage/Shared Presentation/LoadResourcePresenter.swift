//
//  LoadResourcePresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import Foundation

public final class LoadResourcePresenter {
    private let balanceView: BalanceView
    private let loadingView: BalanceLoadingView
    private let errorView: BalanceErrorView
    
    private var balancceLoadError: String {
        return NSLocalizedString("BALANCE_VIEW_CONNECTION_ERROR",
                                 tableName: "Balance",
                                 bundle: Bundle(for: BalancePresenter.self),
                                 comment: "Error message displayed when we can't load the image feed from the server")
    }
    
    public init(balanceView: BalanceView, loadingView: BalanceLoadingView, errorView: BalanceErrorView) {
        self.balanceView = balanceView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public func didStartLoadingBalance() {
        errorView.display(.noError)
        loadingView.display(BalanceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingBalance(with balance: BalanceResponse) {
        balanceView.display(BalanceViewModel(balance: balance))
        loadingView.display(BalanceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingBalance(with error: Error) {
        errorView.display(.error(message: balancceLoadError))
        loadingView.display(BalanceLoadingViewModel(isLoading: false))
    }
}
