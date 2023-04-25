//
//  KeychainWalletStoreTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

class KeychainPrivateKeyStoreTests: XCTestCase, PrivateKeyStoreSpecs {
    
    func test_retrieve_deliversNilOnEmptyCache() {
        let sut = makeSUT()

//        assertThatRetrieveDeliversNilsOnEmptyCache(on: sut)
    }

    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()

//        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }

    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()

//        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }

    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()

//        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()

//        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
//        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_insert_deliversErrorOnPreviouslyInsertedCacheValueUpdate() {
        let sut = makeSUT()
        
//        assertThatInsertDeliversErrorOnPreviouslyInsertedCacheValueUpdate(on: sut)
    }
    
    func test_insert_doesNotOverridesPreviouslyInsertedCacheValues() {
        let sut = makeSUT()

//        assertThatInsertDoesNotOverridePreviouslyInsertedCacheValues(on: sut)
    }

    func test_delete_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()

//        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }

    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()

//        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }

    func test_delete_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()

//        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }

    func test_delete_emptiesInsertedCache() {
        let sut = makeSUT()

//        assertThatDeleteEmptiesInsertedPrivateKey(on: sut)
    }

    // - MARK: Helpers

    private func makeSUT(service: String? = nil, file: StaticString = #filePath, line: UInt = #line) -> PrivateKeyStore {
        let sut = KeychainPrivateKeyStore(network: service ?? testSpecificStoreService())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func testSpecificStoreService() -> String {
        return "Keychain.Solana.Test.Store"
    }

}
