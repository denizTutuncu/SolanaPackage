//
//  LoadWalletFromCacheUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

class LoadPrivateKeyFromKeychainCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_loadPrivateKey_requestsCachePrivateKey() {
        let (sut, store) = makeSUT()
        let publicKey = uniqueWallet().publicKey
        
        _ = try? sut.privateKey(for: publicKey)
        
        XCTAssertEqual(store.receivedMessages, [.privateKey(publicKey)])
    }
    
    func test_loadPrivateKey_failsOnRetrievalError() {
        let (sut, store) = makeSUT()
        let publicKey = uniqueWallet().publicKey
        let retrievalError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(retrievalError), for: publicKey, when: {
            store.complete(with: retrievalError)
        })
    }
    
    func test_loadPrivateKey_failsOnEmptyCache() {
        let (sut, store) = makeSUT()
        let publicKey = uniqueWallet().publicKey
        let emptyCacheError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(emptyCacheError), for: publicKey, when: {
            store.completeWithEmptyCache(with: emptyCacheError)
        })
    }
    
    func test_loadPrivateKey_deliversCachedPrivateKeyOnNonEmptyCache() {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWith: .success(privateKey), for: publicKey, when: {
            store.complete(with: privateKey)
        })
    }

    func test_loadPrivateKey_hasNoSideEffectsOnPrivateKeyError() {
        let publicKey = uniqueWallet().publicKey
        let (sut, store) = makeSUT()
        store.complete(with: anyNSError())

        _ = try? sut.privateKey(for: publicKey)

        XCTAssertEqual(store.receivedMessages, [.privateKey(publicKey)])
    }

    func test_loadPrivateKey_hasNoSideEffectsOnEmptyCache() {
        let publicKey = uniqueWallet().publicKey
        let (sut, store) = makeSUT()
        
        let emptyCacheError = anyNSError()
        store.completeWithEmptyCache(with: emptyCacheError)

        _ = try? sut.privateKey(for: publicKey)

        XCTAssertEqual(store.receivedMessages, [.privateKey(publicKey)])
    }

    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalCredentialsLoader, store: CredentialsStoreSpy) {
        let store = CredentialsStoreSpy()
        let sut = LocalCredentialsLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalCredentialsLoader, toCompleteWith expectedResult: Result<PrivateKey, Error>, for publicKey: PublicKey, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        action()
        
        let receivedResult = Result { try sut.privateKey(for: publicKey) }
        
        switch (receivedResult, expectedResult) {
        case let (.success(receivedPrivateKey), .success(expectedPrivateKey)):
            XCTAssertEqual(receivedPrivateKey, expectedPrivateKey, file: file, line: line)
            
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
    
}

