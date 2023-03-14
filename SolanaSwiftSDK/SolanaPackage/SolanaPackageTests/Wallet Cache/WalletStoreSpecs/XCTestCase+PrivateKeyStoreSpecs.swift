//
//  XCTestCase+WalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension PrivateKeyStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrievefailsOnEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let emptyKeyError = anyNSError()
        
        expect(publicKey, sut, toRetrieve: .failure(emptyKeyError), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let emptyKeyError = anyNSError()
        
        expect(publicKey, sut, toRetrieveTwice: .failure(emptyKeyError), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        
        insert(publicKey, privateKey, to: sut)
        let _ = getPrivateKey(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieve: .success(privateKey), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        insert(publicKey, privateKey, to: sut)
        let _ = getPrivateKey(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieveTwice: .success(privateKey), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        let insertionError = insert(publicKey, privateKey, to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDoesNotOverridePreviouslyInsertedCacheValue(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        
        let firstInsertionError = insert(publicKey, privateKey, to: sut)
        XCTAssertNil(firstInsertionError, "Expected to insert cache successfully", file: file, line: line)
        
        let anotherPrivateKey = "Another Private Key"
        let secondInsertionError = insert(publicKey, anotherPrivateKey, to: sut)
        
        XCTAssertNotNil(secondInsertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDoesNotOverridePreviouslyInsertedCacheValues(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        insert(publicKey, privateKey, to: sut)
        
        let latestPublicKey =  uniqueWallet().publicKey
        let latestPrivateKey = "Latest Private Key"
        insert(latestPublicKey, latestPrivateKey, to: sut)
        
        getPrivateKey(latestPublicKey, from: sut)
        expect(latestPublicKey, sut, toRetrieve: .success(latestPrivateKey), file: file, line: line)
        
        getPrivateKey(publicKey, from: sut)
        expect(publicKey, sut, toRetrieve: .success(privateKey), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let deletionError = deleteCache(publicKey, from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        deleteCache(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        insert(publicKey, privateKey, to: sut)
        
        let deletionError = deleteCache(publicKey, from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesInsertedPrivateKey(on sut: CredentialsStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        insert(publicKey, privateKey, to: sut)
        
        deleteCache(publicKey, from: sut)
        
        let privateKeyNotExistError = getPrivateKey(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieve: .failure(privateKeyNotExistError!), file: file, line: line)
    }
    
}

extension PrivateKeyStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ publicKey: PublicKey, _ privateKey: PrivateKey, to sut: CredentialsStore) -> Error? {
        do {
            try sut.insert(publicKey: publicKey, privateKey: privateKey)
            return nil
        } catch let error {
            return error
        }
    }
    
    @discardableResult
    func deleteCache(_ publicKey: PublicKey, from sut: CredentialsStore) -> Error? {
        do {
            try sut.deletePrivateKey(for: publicKey)
            return nil
        } catch {
            return error
        }
    }
    
    @discardableResult
    func getPrivateKey(_ publicKey: PublicKey, from sut: CredentialsStore) -> Error? {
        do {
            let _ = try sut.privateKey(for: publicKey)
            return nil
        } catch let error {
            return error
        }
    }
    
    
    //MARK: - Private Key
    func expect(_ publicKey: PublicKey, _ sut: CredentialsStore, toRetrieveTwice expectedResult: Result<PrivateKey, Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(publicKey, sut, toRetrieve: expectedResult, file: file, line: line)
        expect(publicKey, sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ publicKey: PublicKey,
                _ sut: CredentialsStore,
                toRetrieve expectedResult: Result<PrivateKey, Error>,
                file: StaticString = #filePath, line: UInt = #line)
    {
        let retrievedResult = Result { try sut.privateKey(for: publicKey) }
        
        switch (expectedResult, retrievedResult) {
        case (.failure, .failure):
            break
            
        case let (.success(expected), .success(retrievedPrivateKey)):
            XCTAssertEqual(retrievedPrivateKey, expected, file: file, line: line)
            
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}

