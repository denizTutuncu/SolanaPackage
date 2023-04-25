//
//  CachePublicKeyUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

class CachePublicKeyUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_doesRequestCacheInsertion() {
        let timestamp = Date()
        let publicKeys = uniquePublicKeys()
        let (sut, store) = makeSUT(currentDate: { timestamp })
            
        try? sut.save(publicKeys)
        
        XCTAssertEqual(store.receivedMessages, [.insert(publicKeys, timestamp)])
    }
    
    func test_save_doesRequestCacheInsertionOnDeletionError() {
        let timestamp = Date()
        let publicKeys = uniquePublicKeys()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        
        let deletionError = anyNSError()
        store.completeDeletion(with: deletionError)
        
        try? sut.save(publicKeys)
        XCTAssertEqual(store.receivedMessages, [.insert(publicKeys, timestamp)])
    }
    
    func test_save_doesNotMessageCacheInsertionOnInvalidKeys() {
            let timestamp = Date()
            let invalidPublicKeys = invalidPublicKeys()
            let (sut, store) = makeSUT(currentDate: { timestamp })
            
            try? sut.save(invalidPublicKeys)
            
        XCTAssertEqual(store.receivedMessages, [])
    }
    

    func test_save_requestsNewCacheInsertionWithTimestamp() {
        let timestamp = Date()
        
        let validPublicKeys = uniquePublicKeys()
        let invalidPublicKeys = invalidPublicKeys()
        let allKeys = validPublicKeys + invalidPublicKeys
        
        let (sut, store) = makeSUT(currentDate: { timestamp })
        store.completeDeletionSuccessfully()
        
        try? sut.save(allKeys)
        
        XCTAssertEqual(store.receivedMessages, [.insert(validPublicKeys, timestamp)])
    }
    
    func test_save_failsOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        expect(sut, toCompleteWithError: deletionError, when: {
            store.completeDeletion(with: deletionError)
        })
    }
    
    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSUT()
        let insertionError = anyNSError()
        
        expect(sut, toCompleteWithError: insertionError, when: {
            store.completeDeletionSuccessfully()
            store.completeInsertion(with: insertionError)
        })
    }
    
    func test_save_succeedsOnSuccessfulCacheInsertion() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWithError: nil, when: {
            store.completeDeletionSuccessfully()
            store.completeInsertionSuccessfully()
        })
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalPublicKeyLoader, store: PublicKeyStoreSpy) {
        let store = PublicKeyStoreSpy()
        let sut = LocalPublicKeyLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalPublicKeyLoader, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        action()
        
        do {
            try sut.save(uniquePublicKeys())
        } catch {
            XCTAssertEqual(error as NSError?, expectedError, file: file, line: line)
        }
    }
    
}

