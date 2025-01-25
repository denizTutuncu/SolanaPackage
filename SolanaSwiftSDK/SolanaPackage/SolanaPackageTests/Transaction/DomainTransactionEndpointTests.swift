//
//  DomainTransactionEndpointTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/23/25.
//

import XCTest
import SolanaPackage

class DomainTransactionEndpointTests: XCTestCase {

    func test_transaction_endpointURLThrowsAfterGivenInvalidWalletAddress() {
        let baseURL = URL(string: "http://base-url.com")!
        let invalidPublicKey = ""
                
        XCTAssertThrowsError(
            try TransactionEndpoint.get(publicKey: invalidPublicKey).url(baseURL: baseURL)
        )
        
    }
    
    func test_transaction_endpointURLAfterGivenWalletAddress() {
        let baseURL = URL(string: "https://base-url.com")!
        let publicKey = uniquePublicKey()
        let received = try? TransactionEndpoint.get(publicKey: publicKey).url(baseURL: baseURL)
        
        XCTAssertEqual(received?.url?.scheme, "https", "scheme")
        XCTAssertEqual(received?.url?.host, "base-url.com", "host")
        XCTAssertEqual(received?.url?.absoluteString, "https://base-url.com", "absoluteString")
    }
}
