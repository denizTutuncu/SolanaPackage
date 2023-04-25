//
//  PrivateKeyCahcePolicyUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/20/23.
//

import XCTest
import SolanaPackage

class PrivateKeyCahcePolicyUseCaseTests: XCTestCase {
    
    func test_policy_validatePrivateKey_expectsTrue_withValidPublicKey() {
        let uniquePublicKey = uniquePrivateKey()
        
        let result = PrivateKeyCachePolicy.validate(privateKey: uniquePublicKey)
        
        XCTAssertEqual(result, true, "Expected result False, got \(result) instead")
    }
    
    func test_policy_validatePrivateKey_expectsFalse_withinvalidPublicKey() {
        let empty = ""
        
        let result = PrivateKeyCachePolicy.validate(privateKey: empty)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_PublicKeyPolicy_iSEmpty_ExpectsTrue_WithValidPublicKey() {
        let uniquePublicKey = uniquePublicKey()
        
        let result = PrivateKeyCachePolicy.validate(publicKey: uniquePublicKey)
        
        XCTAssertEqual(result, true, "Expected result False, got \(result) instead")
    }
    
    func test_policy_validatePublicKey_expectsFalse_withInvalidPublicKey() {
        let empty = ""
        
        let result = PrivateKeyCachePolicy.validate(publicKey: empty)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
}
