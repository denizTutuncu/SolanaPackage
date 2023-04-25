//
//  XCTestCase+PublicKeyStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

extension PublicKeyStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKeys = uniquePublicKeys()
        let timestamp = Date()
        
        insert((publicKeys, timestamp), to: sut)
        
        expect(sut, toRetrieve: .success(CachedPublicKey(publicKeys: publicKeys, timestamp: timestamp)), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKeys = uniquePublicKeys()
        let timestamp = Date()
        
        insert((publicKeys, timestamp), to: sut)
        
        expect(sut, toRetrieveTwice: .success(CachedPublicKey(publicKeys: publicKeys, timestamp: timestamp)), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniquePublicKeys(), Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniquePublicKeys(), Date()), to: sut)
        
        let insertionError = insert((uniquePublicKeys(), Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
    }
    
    func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniquePublicKeys()
        insert((publicKey, Date()), to: sut)
        
        let latestPublicKeys = uniquePublicKeys() + ["Fourth unique public Key"]
        let latestTimestamp = Date()
        insert((latestPublicKeys, latestTimestamp), to: sut)
        
        expect(sut, toRetrieve: .success(CachedPublicKey(publicKeys: latestPublicKeys, timestamp: latestTimestamp)), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(publicKeys: [], from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        deleteCache(publicKeys: [], from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniquePublicKeys(), Date()), to: sut)
        
        let deletionError = deleteCache(publicKeys: uniquePublicKeys(), from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniquePublicKeys(), Date()), to: sut)
        
        deleteCache(publicKeys: uniquePublicKeys(), from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
}

extension PublicKeyStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ cache: (publicKeys: [String], timestamp: Date), to sut: PublicKeyStore) -> Error? {
        do {
            try sut.insert(cache.publicKeys, timestamp: cache.timestamp)
            return nil
        } catch {
            return error
        }
    }
    
    @discardableResult
    func deleteCache(publicKeys: [String], from sut: PublicKeyStore) -> Error? {
        do {
            try sut.deleteCached(publicKeys)
            return nil
        } catch {
            return error
        }
    }
    
    func expect(_ sut: PublicKeyStore, toRetrieveTwice expectedResult: Result<CachedPublicKey?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: PublicKeyStore, toRetrieve expectedResult: Result<CachedPublicKey?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        let retrievedResult = Result { try sut.retrieve() }
        
        switch (expectedResult, retrievedResult) {
        case (.success(.none), .success(.none)),
             (.failure, .failure):
            break
            
        case let (.success(.some(expected)), .success(.some(retrieved))):
            XCTAssertEqual(retrieved.publicKeys, expected.publicKeys, file: file, line: line)
            XCTAssertEqual(retrieved.timestamp, expected.timestamp, file: file, line: line)
            
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}

