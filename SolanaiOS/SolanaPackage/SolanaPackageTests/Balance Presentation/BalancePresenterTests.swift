//
//  BalancePresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import XCTest
import SolanaPackage

class BalancePresenterTests: XCTestCase {
    
//    func test_title_isLocalized() {
//        XCTAssertEqual(BalancePresenter.title, localized("BALANCE_VIEW_TITLE"))
//    }
//
//    func test_map_dcreatesViewModel() {
//        let balance = uniqueBalance()
//        let viewModel = BalancePresenter.map(balance)
//        XCTAssertEqual(viewModel.balance, balance)
//    }
//
//    func test_init_doesNotSendMessagesToView() {
//        let (_, view) = makeSUT()
//
//        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
//    }
//
//    func test_didStartLoadingFeed_displaysNoErrorMessageAndStartsLoading() {
//        let (sut, view) = makeSUT()
//
//        sut.didStartLoadingBalance()
//
//        XCTAssertEqual(view.messages, [
//            .display(errorMessage: .none),
//            .display(isLoading: true)
//        ])
//    }
//
//    func test_didFinishLoadingFeed_displaysFeedAndStopsLoading() {
//        let (sut, view) = makeSUT()
//        let balance = uniqueBalance()
//
//        sut.didFinishLoadingBalance(with: balance)
//
//        XCTAssertEqual(view.messages, [
//            .display(balance: balance),
//            .display(isLoading: false)
//        ])
//    }
//
//    func test_didFinishLoadingFeedWithError_displaysLocalizedErrorMessageAndStopsLoading() {
//        let (sut, view) = makeSUT()
//
//        sut.didFinishLoadingBalance(with: anyNSError())
//
//        XCTAssertEqual(view.messages, [
//            .display(errorMessage: localized("GENERIC_CONNECTION_ERROR", table: "Shared")),
//            .display(isLoading: false)
//        ])
//    }
//
//    // MARK: - Helpers
//
//    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: BalancePresenter, view: ViewSpy) {
//        let view = ViewSpy()
//        let sut = BalancePresenter(balanceView: view, loadingView: view, errorView: view)
//        trackForMemoryLeaks(view, file: file, line: line)
//        trackForMemoryLeaks(sut, file: file, line: line)
//        return (sut, view)
//    }
//
//    private func localized(_ key: String, table: String = "Balance", file: StaticString = #file, line: UInt = #line) -> String {
//        let bundle = Bundle(for: BalancePresenter.self)
//        let value = bundle.localizedString(forKey: key, value: nil, table: table)
//        if value == key {
//            XCTFail("Missing localized string for key: \(key) in table \(table)", file: file, line: line)
//        }
//        return value
//    }
//
//    private class ViewSpy: BalanceView, BalanceLoadingView, BalanceErrorView {
//
//        enum Message: Hashable {
//            case display(errorMessage: String?)
//            case display(isLoading: Bool)
//            case display(balance: Balance)
//        }
//
//        private(set) var messages = Set<Message>()
//
//        func display(_ viewModel: BalanceErrorViewModel) {
//            messages.insert(.display(errorMessage: viewModel.message))
//        }
//
//        func display(_ viewModel: BalanceLoadingViewModel) {
//            messages.insert(.display(isLoading: viewModel.isLoading))
//        }
//
//        func display(_ viewModel: BalanceViewModel) {
//            messages.insert(.display(balance: viewModel.balance))
//        }
//    }
}

