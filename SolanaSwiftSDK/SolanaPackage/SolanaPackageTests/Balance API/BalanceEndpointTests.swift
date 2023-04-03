//
//  BalanceEndpointTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/11/23.
//

import XCTest
import SolanaPackage

class BalanceEndpointTests: XCTestCase {

    func test_balance_endpointURLThrowsAfterGivenInvalidWalletAddress() {
        let baseURL = URL(string: "http://base-url.com")!
        let invalidWallet = DomainWallet(id: "")
                
        XCTAssertThrowsError(
            try BalanceEndpoint.get(walletAddress: invalidWallet.id).url(baseURL: baseURL)
        )
        
    }
    
    func test_balance_endpointURLAfterGivenWalletAddress() {
        let baseURL = URL(string: "https://base-url.com")!
        let publicKey = uniqueWallet().id
        let received = try? BalanceEndpoint.get(walletAddress: publicKey).url(baseURL: baseURL)
        
        XCTAssertEqual(received?.url?.scheme, "https", "scheme")
        XCTAssertEqual(received?.url?.host, "base-url.com", "host")
        XCTAssertEqual(received?.url?.absoluteString, "https://base-url.com", "absoluteString")
    }
}
