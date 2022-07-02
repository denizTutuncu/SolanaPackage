////
////  BalancePresenter.swift
////  SolanaPackage
////
////  Created by Deniz Tutuncu on 5/31/22.
////
//
//import Foundation
//
//public protocol BalanceView {
//    func display(_ viewModel: BalanceViewModel)
//}
//
//public protocol BalanceLoadingView {
//    func display(_ viewModel: BalanceLoadingViewModel)
//}
//
//public protocol BalanceErrorView {
//    func display(_ viewModel: BalanceErrorViewModel)
//}
//
//public final class BalancePresenter {
//    private let balanceView: BalanceView
//    private let loadingView: BalanceLoadingView
//    private let errorView: BalanceErrorView
//
//    private var balanceLoadError: String {
//        return NSLocalizedString("GENERIC_CONNECTION_ERROR",
//                                 tableName: "Shared",
//                                 bundle: Bundle(for: BalancePresenter.self),
//                                 comment: "Error message displayed when we can't load the image feed from the server")
//    }
//
//    public init(balanceView: BalanceView, loadingView: BalanceLoadingView, errorView: BalanceErrorView) {
//        self.balanceView = balanceView
//        self.loadingView = loadingView
//        self.errorView = errorView
//    }
//
//    public static var title: String {
//        return NSLocalizedString("BALANCE_VIEW_TITLE", tableName: "Balance", bundle: Bundle(for: BalancePresenter.self), comment: "Title for the balance view")
//    }
//
//    public func didStartLoadingBalance() {
//        errorView.display(.noError)
//        loadingView.display(BalanceLoadingViewModel(isLoading: true))
//    }
//
//    public func didFinishLoadingBalance(with balance: Balance) {
//        balanceView.display(Self.map(balance))
//        loadingView.display(BalanceLoadingViewModel(isLoading: false))
//    }
//
//    public func didFinishLoadingBalance(with error: Error) {
//        errorView.display(.error(message: balanceLoadError))
//        loadingView.display(BalanceLoadingViewModel(isLoading: false))
//    }
//
//    public static func map(_ balance: Balance) -> BalanceViewModel {
//        BalanceViewModel(balance: balance)
//    }
//}
