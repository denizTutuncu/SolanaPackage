//
//  BalanceUITests.swift
//  SolanaPackageUITests
//
//  Created by Deniz Tutuncu on 7/1/22.
//

import XCTest
import SolanaPackage
import SolanaPackageUI

class BalanceUIIntegrationTests: XCTestCase {
    
    func test_SUTNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_SUTBodyNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.body)
    }
    
    private func makeSUT() -> BalanceComposerView {
        let balance = Balance(lamports: 25000000000)
        let viewModel = BalanceViewModel(balance: balance)
        let balanceView = BalanceView(balance: viewModel)
        let errorMessage = "Any error message"
        let errorView = BalanceErrorView(errorMessage: errorMessage)
        let loadingViewTitle = "Loading..."
        let loadingView = BalanceLoadingView(title: loadingViewTitle)
        let sut = BalanceComposerView(balanceView: balanceView, errorView: errorView, loadingView: loadingView)
        return sut
    }
}
