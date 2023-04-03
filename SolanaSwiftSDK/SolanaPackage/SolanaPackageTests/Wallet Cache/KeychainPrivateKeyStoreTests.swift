//
//  KeychainWalletStoreTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

//class KeychainPrivateKeyStoreTests: XCTestCase, PrivateKeyStoreSpecs {
//
//    func test_retrieve_failsOnEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatRetrievefailsOnEmptyCache(on: sut)
//    }
//
//    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
//    }
//
//    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
//    }
//
//    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
//    }
//
//    func test_insert_deliversNoError() {
//        let sut = makeSUT()
//
//        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
//    }
//
//
//    func test_insert_doesNotOverridesPreviouslyInsertedCacheValue() {
//        let sut = makeSUT()
//
//        assertThatInsertDoesNotOverridePreviouslyInsertedCacheValue(on: sut)
//    }
//
//    func test_insert_doesNotOverridesPreviouslyInsertedCacheValues() {
//        let sut = makeSUT()
//
//        assertThatInsertDoesNotOverridePreviouslyInsertedCacheValues(on: sut)
//    }
//
//
//    func test_delete_deliversNoErrorOnEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
//    }
//
//    func test_delete_hasNoSideEffectsOnEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
//    }
//
//    func test_delete_deliversNoErrorOnNonEmptyCache() {
//        let sut = makeSUT()
//
//        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
//    }
//
//    func test_delete_emptiesInsertedCache() {
//        let sut = makeSUT()
//
//        assertThatDeleteEmptiesInsertedPrivateKey(on: sut)
//    }
//
//    // - MARK: Helpers
//
//    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> CredentialsStore {
//        let service = "Keychain.Solana.Test.Store"
//        let sut = KeychainPrivateKeyStore(network: service)
//        trackForMemoryLeaks(sut, file: file, line: line)
//        return sut
//    }
//
//}
