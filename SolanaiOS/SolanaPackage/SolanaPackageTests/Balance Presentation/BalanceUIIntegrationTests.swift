//
//  BalanceUIIntegrationTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 6/1/22.
//

//MARK:- !! !! !! IMPORTANT !! !! !!
//MARK:- MOVE THIS FILE TO FUTURE SOLANA iOS APP MODULE

import XCTest
import SolanaPackage

extension BalanceUIIntegrationTests {
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) { }
    }
    
    var loadError: String {
        LoadResourcePresenter<Any, DummyView>.loadError
    }
    
    var balanceTitle: String {
        BalancePresenter.title
    }
    
}

//MARK:- !! !! !! IMPORTANT !! !! !!
//MARK:- ADD MISSING TESTS AND MOVE THIS FILE TO FUTURE SOLANA iOS APP MODULE

class BalanceUIIntegrationTests: XCTestCase {

//    func test_balanceView_hasTitle() {
//        let (sut, _) = makeSUT()
//    }
//    
//    //MARK: - Helpers
//    
//    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: BalanceViewController, loader: LoaderSpy) {
//        let loader = LoaderSpy()
//        let sut = BalanceUIComposer.balanceComposedWith(balanceLoader: loader)
//        trackForMemoryLeaks(loader, file: file, line: line)
//        trackForMemoryLeaks(sut, file: file, line: line)
//        return (sut, loader)
//    }
}
