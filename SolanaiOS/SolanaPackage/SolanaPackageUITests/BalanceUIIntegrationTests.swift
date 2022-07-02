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
    
    private func makeSUT() -> BalanceComposerView {
        let viewModel = BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: anyURL(), publicKey: anyKey(), client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))))
        let sut = BalanceComposerView(viewModel: viewModel)
        return sut
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://anyURL.com")!
    }
    
    private func anyKey() -> String {
        "Any Address"
    }

}
