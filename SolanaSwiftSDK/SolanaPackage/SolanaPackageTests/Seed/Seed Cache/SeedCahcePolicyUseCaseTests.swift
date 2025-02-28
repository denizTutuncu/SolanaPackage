//
//  SeedCahcePolicyUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/3/23.
//

import XCTest
import SolanaPackage

class SeedCahcePolicyUseCaseTests: XCTestCase {
    
    func test_SeedCachePolicy_ValidateBank_ExpectsFalse_WithInvalidBank() {
        let emptyBank: [String] = []
        
        let result = SeedCachePolicy.validateBank(seedBank: emptyBank)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_SeedCachePolicy_ValidateBank_ExpectsTrue_WithInvalidBank() {
        let result = SeedCachePolicy.validateBank(seedBank: seedBank())
        
        XCTAssertEqual(result, true, "Expected result True, got \(result) instead")
    }
    
    func test_SeedCachePolicy_GetRandomSeedPhrase_ReturnsEmpty_FromEmpty() {
        let emptyBank: [String] = []
        
        let result = SeedCachePolicy.getRandomSeedPhrase(from: emptyBank)
        
        XCTAssertEqual(result, emptyBank, "Expected result False, got \(result) instead")
    }
    
    func test_SeedCachePolicy_GetRandomSeedPhrase_ReturnsValidSeedPhrase() {
        let result = SeedCachePolicy.getRandomSeedPhrase(from: seedBank())
        XCTAssertEqual(result.count, 12, "Expected result 24 seed, got \(result) instead")
    }
    
    func test_SeedCachePolicy_validateSeedPhrase_ReturnsFalse_WithInvalidSeedPhrase() {
        let emptySeedPhrase: [String] = []
        
        let result = SeedCachePolicy.validateSeedPhrase(seed: emptySeedPhrase)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_SeedCachePolicy_validateSeedPhrase_ReturnsTrue_WithValidSeedPhrase() {
        let result = SeedCachePolicy.validateSeedPhrase(seed: seedPhrase())
        XCTAssertEqual(result, true, "Expected result True, got \(result) instead")
    }
        
    func test_SeedCachePolicy_hasUniqueItems_ReturnsFalse_WithInvalidSeedPhrase() {
        let emptyArray: [String] = []

        let result = SeedCachePolicy.hasUniqueItems(emptyArray)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_SeedCachePolicy_hasUniqueItems_ReturnsTrue_WithValidSeedPhrase() {
        let result = SeedCachePolicy.hasUniqueItems(seedPhrase())
        XCTAssertEqual(result, true, "Expected result True, got \(result) instead")
    }
        
    func test_SeedCachePolicy_singleSeedCount_ReturnsFalse_WithInvalidSeedPhrase() {
        let emptySeedArray: [String] = []

        let result = SeedCachePolicy.singleSeedCount(in: emptySeedArray)
        
        XCTAssertEqual(result, false, "Expected result False, got \(result) instead")
    }
    
    func test_SeedCachePolicy_singleSeedCount_ReturnsTrue_WithValidSeedPhrase() {
        let result = SeedCachePolicy.singleSeedCount(in: seedPhrase())
        XCTAssertEqual(result, true, "Expected result True, got \(result) instead")
    }
    
}
