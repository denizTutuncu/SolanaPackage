//
//  CachePrivateKeyUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

class CachePrivateKeyUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_requestCacheInsertion() {
        let publicKey = uniquePublicKey()
        let (sut, store) = makeSUT()    
        let deletionError = anyNSError()
        store.completeDeletion(with: deletionError)
        
        try? sut.save(publicKey, privateKey: uniquePrivateKey())
        
        XCTAssertEqual(store.receivedMessages, [.insert(publicKey, uniquePrivateKey())])
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
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalPrivateKeyLoader, store: PrivateKeyStoreSpy) {
        let store = PrivateKeyStoreSpy()
        let sut = LocalPrivateKeyLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    

    private func expect(_ sut: LocalPrivateKeyLoader, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        action()
        
        do {
            try sut.save(uniquePublicKey(), privateKey: uniquePrivateKey())
        } catch {
            XCTAssertEqual(error as NSError?, expectedError, file: file, line: line)
        }
    }
    
}
