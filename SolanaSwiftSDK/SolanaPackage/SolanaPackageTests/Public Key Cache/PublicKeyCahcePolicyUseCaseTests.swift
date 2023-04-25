//
//  PublicKeyCahcePolicyUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/20/23.
//


import XCTest
import SolanaPackage

class PublicKeyCahcePolicyUseCaseTests: XCTestCase {
    
    func test_policy_isEmpty_expectsTrue_withValidPublicKeys() {
        let validPublicKeys = uniquePublicKeys()
        
        let result = PublicKeyCachePolicy.isEmpty(validPublicKeys)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_policy_isEmpty_expectsFalse_withInvalidPublicKeys() {
        let empty: [String] = []
        
        let result = PublicKeyCachePolicy.isEmpty(empty)
        
        XCTAssertEqual(result, true, "Expected result False, got \(result) instead")
    }
    
    func test_policy_getInvalidPublicKeys_expectsEmpty_fromEmptyKeys() {
        let empty: [String] = []
        
        let result = PublicKeyCachePolicy.getInvalidPublicKeys(from: empty)
        
        XCTAssertEqual(result, empty, "Expected result False, got \(result) instead")
    }
    
    func test_policy_getInvalidPublicKeys_expectsInvalidPublicKeys() {
        let invalidPublicKeys = invalidPublicKeys()
        
        let result = PublicKeyCachePolicy.getInvalidPublicKeys(from: invalidPublicKeys)
        
        XCTAssertEqual(result, invalidPublicKeys, "Expected result False, got \(result) instead")
    }
    
    
    func test_policy_getValidPublicKeys_expectsValidPublicKeys() {
        let validPublicKeys = uniquePublicKeys()
        
        let result = PublicKeyCachePolicy.getValidPublicKeys(from: validPublicKeys)
        
        XCTAssertEqual(result, validPublicKeys, "Expected result False, got \(result) instead")
    }
    
    func test_policy_getValidPublicKeys_expectsEmpty_fromEmptyKeys() {
        let empty: [String] = []
        
        let result = PublicKeyCachePolicy.getValidPublicKeys(from: empty)
        
        XCTAssertEqual(result, empty, "Expected result False, got \(result) instead")
    }
}
