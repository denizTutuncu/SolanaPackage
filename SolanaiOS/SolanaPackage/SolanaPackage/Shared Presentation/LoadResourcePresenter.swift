//
//  LoadResourcePresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import Foundation

public protocol ResourceView {
    func display(_ viewModel: String)
}

public final class LoadResourcePresenter {
    public typealias Mapper = (String) -> String
    
    private let resourceView: ResourceView
    private let loadingView: BalanceLoadingView
    private let errorView: BalanceErrorView
    private let mapper: Mapper
    
    private var balancceLoadError: String {
        return NSLocalizedString("BALANCE_VIEW_CONNECTION_ERROR",
                                 tableName: "Balance",
                                 bundle: Bundle(for: BalancePresenter.self),
                                 comment: "Error message displayed when we can't load the image feed from the server")
    }
    
    public init(resourceView: ResourceView, loadingView: BalanceLoadingView, errorView: BalanceErrorView, mapper: @escaping Mapper) {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(BalanceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: String) {
        resourceView.display(mapper(resource))
        loadingView.display(BalanceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingBalance(with error: Error) {
        errorView.display(.error(message: balancceLoadError))
        loadingView.display(BalanceLoadingViewModel(isLoading: false))
    }
}
