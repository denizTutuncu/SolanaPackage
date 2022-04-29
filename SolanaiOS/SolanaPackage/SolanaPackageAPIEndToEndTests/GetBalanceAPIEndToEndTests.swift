//
//  SolanaPackageAPIEndToEndTests.swift
//  SolanaPackageAPIEndToEndTests
//
//  Created by Deniz Tutuncu on 3/20/22.
//

import XCTest
import SolanaPackage

class GetBalanceAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETBalanceResult_matchesFixedTestAccountData() {
        let expectedResponse = createExpectedResponse()
        switch getBalanceResponse() {
        case let .success(remoteResponse)?:
            XCTAssertNotEqual(remoteResponse, nil, "Expected non-empty response.")
            XCTAssertEqual(remoteResponse.result.value, expectedResponse.result.value, "Expected response doesn't match with remote response. Please first thing compare the RCP endpoints. Your balance may exist in a different Network.")
            
        case let .failure(error):
            XCTFail("Expected successful getBalanceResponse, got \(error) instead.")
        default:
            XCTFail("Expected successful getBalanceResponse, got no result instead.")
        }
    }
    
    //MARK:- Helpers
    private func getBalanceResponse(file: StaticString = #file, line: UInt = #line) -> RemoteGetBalanceLoader.Result? {
        let request = makeGetSolAccInfoRequest()
        let requestMaker = GetBalanceURLRequestMaker(rpcEndpoint: SolanaClusterRPCEndpoints.devNet)
        let loader = RemoteGetBalanceLoader(client: ephemeralClient(), urlMaker: requestMaker)
        
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait For Completion")
        
        var receivedResult: RemoteGetBalanceLoader.Result?
        loader.perform(pubKey: request.params.first!) { result in
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
    
    private func makeGetSolAccInfoRequest() -> GetBalanceRequest {
        let publicKey = createPublicKey()
        let request = GetBalanceRequest(params: [publicKey])
     
        return request
    }
    
    private func createExpectedResponse() -> GetBalanceResponse {
        return GetBalanceResponse(jsonrpc: "2.0", result: GetBalanceResult(context: GetBalanceContext(slot: 123838291), value: 25000000000), id: 1)
    }
    
}
