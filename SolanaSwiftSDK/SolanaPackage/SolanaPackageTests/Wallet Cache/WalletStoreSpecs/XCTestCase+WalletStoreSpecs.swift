//
//  XCTestCase+WalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension WalletStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        let wallet = uniqueWalletFeed().local
        let timestamp = Date()
        
        insert((wallet, timestamp), to: sut)
        
        expect(sut, toRetrieve: .success(CachedWallet(wallet: wallet, timestamp: timestamp)), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        let wallet = uniqueWalletFeed().local
        let timestamp = Date()
        
        insert((wallet, timestamp), to: sut)
        
        expect(sut, toRetrieveTwice: .success(CachedWallet(wallet: wallet, timestamp: timestamp)), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueWalletFeed().local, Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueWalletFeed().local, Date()), to: sut)
        
        let insertionError = insert((uniqueWalletFeed().local, Date()), to: sut)
        
        XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
    }
    
    func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueWalletFeed().local, Date()), to: sut)
        
        let latestWallet = uniqueWalletFeed().local
        let latestTimestamp = Date()
        insert((latestWallet, latestTimestamp), to: sut)
        
        expect(sut, toRetrieve: .success(CachedWallet(wallet: latestWallet, timestamp: latestTimestamp)), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueWalletFeed().local, Date()), to: sut)
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueWalletFeed().local, Date()), to: sut)
        
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
}

extension WalletStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ cache: (wallet: [LocalWallet], timestamp: Date), to sut: WalletStore) -> Error? {
        do {
            try sut.insert(cache.wallet, timestamp: cache.timestamp)
            return nil
        } catch {
            return error
        }
    }
    
    @discardableResult
    func deleteCache(from sut: WalletStore) -> Error? {
        do {
            try sut.deleteCachedWallet()
            return nil
        } catch {
            return error
        }
    }
    
    func expect(_ sut: WalletStore, toRetrieveTwice expectedResult: Result<CachedWallet?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: WalletStore, toRetrieve expectedResult: Result<CachedWallet?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        let retrievedResult = Result { try sut.retrieve() }
        
        switch (expectedResult, retrievedResult) {
        case (.success(.none), .success(.none)),
             (.failure, .failure):
            break
            
        case let (.success(.some(expected)), .success(.some(retrieved))):
            XCTAssertEqual(retrieved.wallet, expected.wallet, file: file, line: line)
            XCTAssertEqual(retrieved.timestamp, expected.timestamp, file: file, line: line)
            
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}

