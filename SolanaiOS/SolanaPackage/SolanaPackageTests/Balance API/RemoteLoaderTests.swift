//
//  RemoteLoaderTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/24/22.
//

import XCTest
import SolanaPackage

class RemoteLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnMapperError() {
        let (sut, client) = makeSUT(mapper: { _, _ in
            throw anyNSError()
        })
        
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            client.complete(withStatusCode: 200, data: anyData())
        })
    }
    
    func test_load_deliversMappedResource() {
        let resource = "a resource"
        let (sut, client) = makeSUT(mapper: { data, _ in
            String(data: data, encoding: .utf8)!
        })
        
        expect(sut, toCompleteWith: .success(resource), when: {
            client.complete(withStatusCode: 200, data: Data(resource.utf8))
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = anyURL()
        let client = HTTPClientSpy()
        let publicKey = createPublicKey()
        let methodName = "getBalance"
        var sut: RemoteLoader<String>? = RemoteLoader<String>(url: url,
                                                              methodName: methodName,
                                                              publicKey: publicKey,
                                                              client: client,
                                                              urlRequestMapper: { _,_,_  in testURLRequest() },
                                                              mapper: { _, _ in "any" })
        
        var capturedResults = [RemoteLoader<String>.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeItemJSON([:]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    
    private func makeSUT(
        url: URL = anyURL(),
        mapper: @escaping RemoteLoader<String>.ResponseMapper = { _, _ in "any" },
        urlRequestMapper: @escaping RemoteLoader<String>.URLRequestMapper = { _,_,_  in testURLRequest() },
        file: StaticString = #file,
        line: UInt = #line
    ) -> (sut: RemoteLoader<String>, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let publicKey = createPublicKey()
        let methodName = "getBalance"
        let sut = RemoteLoader<String>(url: url,
                                       methodName: methodName,
                                       publicKey: publicKey,
                                       client: client,
                                       urlRequestMapper: urlRequestMapper,
                                       mapper: mapper)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: RemoteLoader<String>.Error) -> RemoteLoader<String>.Result {
        return .failure(error)
    }
    
    private func aGivenURL() -> URL {
        URL(string: "https://a-given-url.com")!
    }
    
    private func createPublicKey() -> String {
        let pubKey = "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
        return pubKey
    }
    
    private func makeResponseItem() -> (model: BalanceResponse, json: [String:Any]) {
        let fakeResponse = BalanceResponse(jsonrpc: "2.0", result: BalanceResult(context: BalanceContext(slot: 124067037), value: 25000000000), id: 1)
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
        
        return (fakeResponse, json)
    }
    
    private func makeItemJSON(_ items: [String:Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
    private func expect(_ sut: RemoteLoader<String>, toCompleteWith expectedResult: RemoteLoader<String>.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteLoader<String>.Error), .failure(expectedError as RemoteLoader<String>.Error)):
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
