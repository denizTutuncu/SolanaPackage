//
//  KeychainWalletStoreTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

class KeychainPrivateKeyStoreTests: XCTestCase, PrivateKeyStoreSpecs {
    
//    override func setUp() {
//        super.setUp()
//        setupEmptyStoreState()
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        undoStoreSideEffects()
//    }
    
    func test_retrieve_deliversNilOnEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatRetrieveDeliversNilOnEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_insert_deliversErrorOnPreviouslyInsertedCacheValueUpdate() {
//        let sut = makeSUT()
        
//        assertThatInsertDeliversErrorOnPreviouslyInsertedCacheValueUpdate(on: sut)
    }
    
    func test_insert_doesNotOverridesPreviouslyInsertedCacheValues() {
//        let sut = makeSUT()
        
//        assertThatInsertDoesNotOverridePreviouslyInsertedCacheValues(on: sut)
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
//        let sut = makeSUT()
        
//        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_delete_emptiesInsertedCache() {
//        let sut = makeSUT()
        
//        assertThatDeleteEmptiesInsertedPrivateKey(on: sut)
    }
    
    // - MARK: Helpers
    
    private func makeSUT(service: String? = nil, file: StaticString = #filePath, line: UInt = #line) -> PrivateKeyStore {
        let sut = KeychainPrivateKeyStore(network: service ?? testSpecificStoreService())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrServer as String: testSpecificStoreService(),
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecReturnAttributes as String: true
        ]
        
        var items: CFTypeRef?
        let searchStatus = SecItemCopyMatching(deleteQuery as CFDictionary, &items)
        
        guard searchStatus != errSecItemNotFound else { return }
        guard searchStatus == errSecSuccess else {
            XCTFail("Failed to find keychain items via \(searchStatus.description)")
            return
        }
        
        switch SecItemDelete(deleteQuery as CFDictionary) {
        case errSecItemNotFound, errSecSuccess: break
        case errSecUserCanceled:
            XCTFail("User canceled the operation.")
        case errSecAuthFailed:
            XCTFail("Authentication failed while accessing the keychain item.")
        case let status:
            XCTFail("Failed to delete keychain item via \(status.description)")
        }
    }
    
    private func testSpecificStoreService() -> String {
        return "Keychain.Solana.Test.Store"
    }
}
