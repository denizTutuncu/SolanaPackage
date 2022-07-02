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
    
    func test_init_SUTNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_init_SUTBodyNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.body)
    }
    
    func test_init_SUTPublisherNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.view)
    }
    
    
    private func makeSUT() -> BalanceComposerView {
        let viewModel = BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: anyURL(), methodName: anyMethod(), publicKey: anyKey(), client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))))
        let sut = BalanceComposerView(viewModel: viewModel)
        return sut
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://anyURL.com")!
    }
    
    private func anyMethod() -> String {
        "any method name"
    }
    
    private func anyKey() -> String {
        "Any Address"
    }

}
