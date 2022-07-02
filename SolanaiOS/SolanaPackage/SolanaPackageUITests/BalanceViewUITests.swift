////
////  BalanceViewUITests.swift
////  SolanaPackageUITests
////
////  Created by Deniz Tutuncu on 7/1/22.
////
//
//import XCTest
//import SolanaPackage
//import SolanaPackageUI
//
//class BalanceViewUITests: XCTestCase {
//    
//    func test_SUTNotNil() {
//        let sut = makeSUT()
//        XCTAssertNotNil(sut)
//    }
//    
//    private func makeSUT() -> BalanceUIView {
//        let viewModel = BalanceViewModel(remoteBalanceLoader: RemoteBalanceLoader(url: anyURL(), methodName: anyMethod(), publicKey: anyKey(), client: HTTPClientSpy()))
//        let sut = BalanceUIView(viewModel: viewModel)
//        return sut
//    }
//    
//    private func anyURL() -> URL {
//        return URL(string: "https://anyURL.com")!
//    }
//    
//    private func anyMethod() -> String {
//        "any method name"
//    }
//    
//    private func anyKey() -> String {
//        "Any Address"
//    }
//    
//    private class HTTPClientSpy: HTTPClient {
//        
//        func get(from urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
//            
//        }
//        
//    }
//    
//}
