//
//  LoadBalanceCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import XCTest
import SolanaPackage

class LoadBalanceCaseTests: XCTestCase {
    
    func test_load_deliversErrorOnNon2xxHTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 150, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let json = makeItemJSON([:])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn2xxHTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        let samples = [200, 201, 250, 280, 299]
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let invalidJSON = Data("invalid json".utf8)
                client.complete(withStatusCode: code, data: invalidJSON, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn2xxHTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()
        let samples = [200, 201, 250, 280, 299]
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let emptyData = makeItemJSON([:])
                client.complete(withStatusCode: code, data: emptyData, at: index)
            })
        }
    }
    
    //MARK:- helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteBalanceLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let publicKey = createPublicKey()
        let sut = RemoteBalanceLoader(url: url, methodName: "getBalance", publicKey: publicKey, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    private func createPublicKey() -> String {
        let pubKey = "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
        return pubKey
    }
    
    private func makeResponseItem() -> (model: Balance, json: [String:Any]) {
        let model = Balance(value: 25000000000)
        let json: [String:Any] = [
            "jsonrpc": "2.0",
            "result": [
                "context": [
                    "slot": 124067037
                ],
                "value": 25000000000
            ],
            "id": 1
        ].compactMapValues { $0 }
        
        return (model, json)
    }
    
    private func makeItemJSON(_ items: [String:Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
    private func failure(_ error: RemoteBalanceLoader.Error) -> RemoteBalanceLoader.Result {
        return .failure(error)
    }
    
    private func expect(_ sut: RemoteBalanceLoader, toCompleteWith expectedResult: RemoteBalanceLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError as RemoteBalanceLoader.Error), .failure(expectedError as RemoteBalanceLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
                
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
}

