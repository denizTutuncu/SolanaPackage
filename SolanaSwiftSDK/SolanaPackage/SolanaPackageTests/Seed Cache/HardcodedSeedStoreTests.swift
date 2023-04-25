//
//  HardcodedSeedStoreUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/16/23.
//

import XCTest
import SolanaPackage

class HardcodedSeedStoreTests: XCTestCase, SeedBankStoreSpecs {
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let (sut) = makeSUT()
        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT(with: seedBank())
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT(with: seedBank())
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
        
    // MARK: - Helpers
    
    private func makeSUT(with seed: [String] = [], file: StaticString = #filePath, line: UInt = #line) -> SeedStore {
        let sut = HardcodedSeedStore(seed: seed)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut)
    }

}
