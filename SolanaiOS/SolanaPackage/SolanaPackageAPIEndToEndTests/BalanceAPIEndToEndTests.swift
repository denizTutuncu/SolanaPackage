//
//  BalanceAPIEndToEndTests.swift
//  SolanaPackageAPIEndToEndTests
//
//  Created by Deniz Tutuncu on 3/20/22.
//

import XCTest
import SolanaPackage

class BalanceAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        switch getBalanceResult() {
        case let .success(balance)?:
            XCTAssertEqual(balance.lamports, createBalance(), "Expected balance in the test account balance")
            
        case let .failure(error)?:
            XCTFail("Expected successful balance result, got \(error) instead")
            
        default:
            XCTFail("Expected successful balance result, got no result instead")
        }
    }
    
    // MARK: - Helpers
    private func getBalanceResult(file: StaticString = #filePath, line: UInt = #line) -> Swift.Result<Balance, Error>? {
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Swift.Result<Balance, Error>?
        client.get(from: balanceTestServerURL) { result in
            receivedResult = result.flatMap { (data, response) in
                do {
                    return .success(try BalanceItemMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
        
    private var balanceTestServerURL: URLRequest {
        return try! BalanceEndpoint.get(walletAddress: walletAddress()).url(baseURL: baseURL())
    }
    
    private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
    private func expectedBalance(at index: Int) -> Balance {
        return Balance(lamports: createBalance())
    }
    
    private func createBalance() -> Int {
        return 8473919000
    }
    
    private func baseURL() -> URL {
        return URL(string: "https://api.devnet.solana.com")!
    }
    private func walletAddress() -> String {
        return "4nNfoAztZVjRLLcxgcxT7yYUuyn6UgMJdduART94TrKi"
    }
    
}
