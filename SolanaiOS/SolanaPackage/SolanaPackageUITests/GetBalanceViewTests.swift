//
//  GetBalanceViewTests.swift
//  SolanaPackageUITests
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import XCTest
import SwiftUI
import Combine
import SolanaPackage
import SolanaPackageUI

class GetBalanceViewTests: XCTestCase {
    
    func test_init_doesNotLoadBalance() {
        let (_ , loader) = makeSUT()
        
        XCTAssertEqual(loader.loadGetBalanceCallCount, 0)
    }

    func test_init_loadBalance() {
        let (sut, loader) = makeSUT()
        
        XCTAssertEqual(loader.loadGetBalanceCallCount, 1)
    }

    //MARK:- helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: GetBalanceView, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let viewModel = GetBalanceViewModel(loader: loader)
        let sut = GetBalanceView(viewModel: viewModel)
        trackForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }
    
    private func anyValidKey() -> String {
        return "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
    }

    class LoaderSpy: GetBalanceLoader {
        private var getBalanceRequests = [(GetBalanceLoader.Result) -> Void]()

        var loadGetBalanceCallCount: Int {
            return getBalanceRequests.count
        }

        func perform(pubKey: String?, completion: @escaping (GetBalanceLoader.Result) -> Void) {
            getBalanceRequests.append(completion)
        }

        func completeGetBalanceLoading(with getBalanceResponse: GetBalanceResponse, at index: Int = 0) {
            getBalanceRequests[index](.success(getBalanceResponse))
        }

        func completeGetBalanceLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            getBalanceRequests[index](.failure(error))
        }
    }
    
}
