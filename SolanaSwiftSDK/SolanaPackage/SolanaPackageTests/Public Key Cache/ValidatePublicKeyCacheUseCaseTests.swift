//
//  ValidatePublicKeyCacheUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/20/23.
//

import XCTest
import SolanaPackage

class ValidatePublicKeyCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_validateCache_doesNotDeletesCacheOnRetrievalError() {
        let (sut, store) = makeSUT()
        store.completeRetrieval(with: anyNSError())
        
        try? sut.validateCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
        let (sut, store) = makeSUT()
        store.completeRetrievalWithEmptyCache()
        
        try? sut.validateCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_validateCache_doesNotDeleteValidKeys() {
        let validPublicKeys = uniquePublicKeys()
        let timestamp = Date()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        store.completeRetrieval(with: validPublicKeys, timestamp: timestamp)
        
        try? sut.validateCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_validateCache_deletesInvalidCache() {
        let invalidCache = invalidPublicKeys()
        let timestamp = Date()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        store.completeRetrieval(with: invalidCache, timestamp: timestamp)
        
        try? sut.validateCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve,
                                                .deleteCachedPublicKey(invalidCache)])
    }
    
    func test_validateCache_failsOnDeletionErrorOfFailedRetrieval() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(deletionError), when: {
            store.completeRetrieval(with: anyNSError())
            store.completeDeletion(with: deletionError)
        })
    }
    
    func test_validateCache_failsOnSuccessfulDeletionOfFailedRetrieval() {
        let (sut, store) = makeSUT()
        let retrievalError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(retrievalError), when: {
            store.completeRetrieval(with: retrievalError)
            store.completeDeletionSuccessfully()
        })
    }
    
    func test_validateCache_succeedsOnEmptyCache() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWith: .success(()), when: {
            store.completeRetrievalWithEmptyCache()
        })
    }
    
    func test_validateCache_succeedsOnValidCache() {
        let validPublicKeys = uniquePublicKeys()
        let timestamp = Date()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        expect(sut, toCompleteWith: .success(()), when: {
            store.completeRetrieval(with: validPublicKeys, timestamp: timestamp)
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
    
    private func expect(_ sut: LocalPublicKeyLoader, toCompleteWith expectedResult: Result<Void, Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        action()

        let receivedResult = Result { try sut.validateCache() }
        
        switch (receivedResult, expectedResult) {
        case (.success, .success):
            break
            
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }

}
