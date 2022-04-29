//
//  GetAccSolInfoCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import XCTest
import SolanaPackage

class GetBalanceCaseTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURLRequest() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requests.isEmpty)
    }
    
    func test_perform_requestsDataFromURLRequest() {
        let request = getBalanceRequest()
        //system under control
        let (sut, client) = makeSUT()
        //system under control does something
        sut.perform(pubKey: request.params.first) { _ in }
        //Then we check what we want
        XCTAssertEqual(client.requests.first?.url?.absoluteString, SolanaClusterRPCEndpoints.devNet.rawValue)
        XCTAssertEqual(client.requests.first?.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(client.requests.first?.value(forHTTPHeaderField: "Authorization"), nil)
    }
    
    func test_performTwice_requestsDataFromURLTwice() {
        let request = getBalanceRequest()
        let (sut, client) = makeSUT()
        sut.perform(pubKey: request.params.first) { _ in }
        sut.perform(pubKey: request.params.first) { _ in }
        
        XCTAssertEqual(client.requests.count, 2)
    }
    
    func test_perform_deliversErrorOnClientError() {
        let request = getBalanceRequest()
        let (sut, client) = makeSUT()
        expect(pubKey: request.params.first, sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_perform_deliversErrorOnRequestMakerError() {
        let request = getBalanceRequest()
        let client = HTTPClientSpy()
        let requestMaker = GetBalanceRequestMakerSpy()
        let sut = RemoteGetBalanceLoader(client: client, urlMaker: requestMaker)
        
        expect(pubKey: request.params.first, sut, toCompleteWith: failure(.badRequest)) {
            let clientError = NSError(domain: "Test", code: 0)
            requestMaker.complete(with: clientError)
        }
    }
    
    func test_perform_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let request = getBalanceRequest()
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(pubKey: request.params.first, sut, toCompleteWith: failure(.invalidData), when: {
                client.complete(withStatusCode: code, data: anyData(), at: index)
            })
        }
    }
    
    func test_perform_deliversInvalidDataErrorOn200HTTPResponseWithEmptyData() {
        let request = getBalanceRequest()
        let (sut, client) = makeSUT()
        
        expect(pubKey: request.params.first, sut, toCompleteWith: failure(.invalidData), when: {
            let invalidData = Data("InvalidJSON".utf8)
            client.complete(withStatusCode: 200, data: invalidData)
        })
    }
    
    func test_perform_deliversItemsOn200HTTPResponseWithJSONItem() {
        let request = getBalanceRequest()
        let (sut, client) = makeSUT()
        
        let item = makeResponseItem()
        
        expect(pubKey: request.params.first, sut, toCompleteWith: .success(item.model), when: {
            let data = makeItemJSON(item.json)
            client.complete(withStatusCode: 200, data: data)
        })
    }
    
    func test_perform_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let request = getBalanceRequest()
        let client = HTTPClientSpy()
        let requestMaker = GetBalanceURLRequestMaker(rpcEndpoint: SolanaClusterRPCEndpoints.devNet)
        var sut: RemoteGetBalanceLoader? = RemoteGetBalanceLoader(client: client, urlMaker: requestMaker)
        
        var capturedResults = [RemoteGetBalanceLoader.Result]()
        sut?.perform(pubKey: request.params.first) { capturedResults.append($0) }
        
        sut = nil
        let item = makeResponseItem()
        let data = makeItemJSON(item.json)
        client.complete(withStatusCode: 200, data: data)
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    //MARK:- helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RemoteGetBalanceLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let requestMaker = GetBalanceURLRequestMaker(rpcEndpoint: SolanaClusterRPCEndpoints.devNet)

        let sut = RemoteGetBalanceLoader(client: client, urlMaker: requestMaker)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    private func getBalanceRequest() -> GetBalanceRequest {
        let publicKey = createPublicKey()
        let request = GetBalanceRequest(params: [publicKey])
        
        return request
    }
    
    private func createPublicKey() -> String {
        let pubKey = "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
        return pubKey
    }
    
    private func makeResponseItem() -> (model: GetBalanceResponse, json: [String:Any]) {
        let fakeResponse = GetBalanceResponse(jsonrpc: "2.0", result: GetBalanceResult(context: GetBalanceContext(slot: 124067037), value: 25000000000), id: 1)
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
    
    private func failure(_ error: RemoteGetBalanceLoader.Error) -> RemoteGetBalanceLoader.Result {
        return .failure(error)
    }
    
    private func expect(pubKey: String?, _ sut: RemoteGetBalanceLoader, toCompleteWith expectedResult: RemoteGetBalanceLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.perform(pubKey: pubKey) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError as RemoteGetBalanceLoader.Error), .failure(expectedError as RemoteGetBalanceLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expectedd result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
                
            }
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
}

