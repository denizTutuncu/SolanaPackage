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

    func test_init() {
      let sut = makeSUT()
        
    }
    
    private func makeSUT() -> BalanceComposerView {
        let balance = Balance(value: <#T##Int#>)
        let viewModel = BalanceViewModel(balance: <#T##Balance#>)
        let balanceView = BalanceView(balance: <#T##BalanceViewModel#>)
        let sut = BalanceComposerView(balanceView: <#T##BalanceView#>, errorView: <#T##BalanceErrorView#>, loadingView: <#T##BalanceLoadingView#>)
    }
}
