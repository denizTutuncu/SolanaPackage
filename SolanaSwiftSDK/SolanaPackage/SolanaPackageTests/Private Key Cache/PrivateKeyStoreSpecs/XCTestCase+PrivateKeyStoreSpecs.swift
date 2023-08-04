//
//  XCTestCase+WalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension PrivateKeyStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversNilOnEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let nonExistPublicKey = uniquePublicKey()
        
        expect(nonExistPublicKey, sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let nonExistPublicKey = uniquePublicKey()
        
        expect(nonExistPublicKey, sut, toRetrieveTwice: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        expect(publicKey, sut, toRetrieve: .success(privateKey), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        expect(publicKey, sut, toRetrieveTwice: .success(privateKey), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        let insertionError = insert(publicKey, privateKey, to: sut)
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        let anotherPublicKey = anotherUniquePublicKey()
        let anotherPrivateKey = anotherUniquePrivateKey()
        
        let secondInsertionError = insert(anotherPublicKey, anotherPrivateKey, to: sut)
        XCTAssertNil(secondInsertionError, "Expected to insert another cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversErrorOnPreviouslyInsertedCacheValueUpdate(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        let firstInsertionError = insert(publicKey, privateKey, to: sut)
        XCTAssertNil(firstInsertionError, "Expected to insert cache successfully", file: file, line: line)
        
        let anotherPrivateKey = anotherUniquePrivateKey()
        
        let secondInsertionError = insert(publicKey, anotherPrivateKey, to: sut)
        XCTAssertNotNil(secondInsertionError, "Expected to get cache error", file: file, line: line)
    }
    
    func assertThatInsertDoesNotOverridePreviouslyInsertedCacheValues(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        let latestPublicKey =  anotherUniquePublicKey()
        let latestPrivateKey = anotherUniquePrivateKey()
        
        insert(latestPublicKey, latestPrivateKey, to: sut)
        
        expect(latestPublicKey, sut, toRetrieve: .success(latestPrivateKey), file: file, line: line)
        
        expect(publicKey, sut, toRetrieve: .success(privateKey), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        
        let deletionError = deleteCache(publicKey, from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        
        deleteCache(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieveTwice: .success(.none), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        let deletionError = deleteCache(publicKey, from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesInsertedPrivateKey(on sut: PrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKey()
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        
        deleteCache(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
}

extension PrivateKeyStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ publicKey: String, _ privateKey: String, to sut: PrivateKeyStore) -> Error? {
        do {
            try sut.store(publicKey: publicKey, privateKey: privateKey)
            return nil
        } catch let error {
            return error
        }
    }
    
    @discardableResult
    func deleteCache(_ publicKey: String, from sut: PrivateKeyStore) -> Error? {
        do {
            try sut.deleteKey(for: publicKey)
            return nil
        } catch {
            return error
        }
    }
    
    @discardableResult
    func getPrivateKey(_ publicKey: String, from sut: PrivateKeyStore) -> Error? {
        do {
            let _ = try sut.read(for: publicKey)
            return nil
        } catch let error {
            return error
        }
    }
    
    
    //MARK: - Private Key
    func expect(_ publicKey: String, _ sut: PrivateKeyStore, toRetrieveTwice expectedResult: Result<String?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(publicKey, sut, toRetrieve: expectedResult, file: file, line: line)
        expect(publicKey, sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ publicKey: String,
                _ sut: PrivateKeyStore,
                toRetrieve expectedResult: Result<String?, Error>,
                file: StaticString = #filePath, line: UInt = #line)
    {
        let retrievedResult = Result { try sut.read(for: publicKey) }
        
        switch (expectedResult, retrievedResult) {
        case (.success(.none), .success(.none)),
            (.failure, .failure):
            break
            
        case let (.success(.some(expected)), .success(.some(retrievedPrivateKey))):
            XCTAssertEqual(retrievedPrivateKey, expected, file: file, line: line)
            
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}

