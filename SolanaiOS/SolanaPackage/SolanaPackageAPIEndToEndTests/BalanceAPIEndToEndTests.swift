//
//  BalanceAPIEndToEndTests.swift
//  SolanaPackageAPIEndToEndTests
//
//  Created by Deniz Tutuncu on 3/20/22.
//

import XCTest
import SolanaPackage

class BalanceAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETBalanceResult_matchesFixedTestAccountData() {
        let expectedResponse = createExpectedResponse()
        switch getBalance() {
        case let .success(remoteResponse)?:
            XCTAssertNotEqual(remoteResponse, nil, "Expected non-empty response.")
            XCTAssertEqual(remoteResponse.value, expectedResponse.value, "Expected response doesn't match with remote response. Please first thing compare the RCP endpoints. Your balance may exist in a different Network.")
            
        case let .failure(error):
            XCTFail("Expected successful getBalanceResponse, got \(error) instead.")
        default:
            XCTFail("Expected successful getBalanceResponse, got no result instead.")
        }
    }
    
    //MARK:- Helpers
    private func getBalance(file: StaticString = #file, line: UInt = #line) -> Swift.Result<Balance, Error>?  {
        let devNetURL = URL(string: BalanceEndpoint.devNet.rawValue)
        let publicKey = createPublicKey()
        let methodName = "getBalance"
        let loader = RemoteLoader(url: devNetURL, methodName: methodName, publicKey: publicKey, client: ephemeralClient(), urlRequestMapper: BalanceURLRequestMapper.map, mapper: BalanceResponseMapper.map)
        
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait For Completion")
        
        var receivedResult: RemoteBalanceLoader.Result?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
        return receivedResult
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
    private func createPublicKey() -> String {
        return "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
    }
        
    private func createExpectedResponse() -> Balance {
        return Balance(value: 25000000000)
    }
    
}
