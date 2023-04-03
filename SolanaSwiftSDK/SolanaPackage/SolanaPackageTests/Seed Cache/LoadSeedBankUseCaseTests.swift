//
//  LoadSeedFromCacheUseCaseTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/14/23.
//


import XCTest
import SolanaPackage

class LoadSeedBankUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestsCachePrivateKey() {
        let (sut, store) = makeSUT()
        
        _ = try? sut.load()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_failsOnRetrievalError() {
        let (sut, store) = makeSUT()
        let retrievalError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(retrievalError), when: {
            store.completeRetrieval(with: retrievalError)
        })
    }
    
    func test_load_deliversEmptySeedOnEmptyCache() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            store.completeRetrievalSuccessfullyWithEmptySeed()
        })
    }
    
    func test_load_deliversEmptySeedOnInvalidCache() {
        let invalidBank = ["invalid", "seed", "phrase"]
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            store.completeRetrievalSuccessfully(with: invalidBank)
        })
    }
    
 
    func test_load_hasNoSideEffectsOnEmptyCache() {
        let (sut, store) = makeSUT()
        store.completeRetrievalSuccessfullyWithEmptySeed()
        
        let seed = try? sut.load()
        
        XCTAssertEqual(seed?.count, 0)
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_hasNoSideEffectsOnInvalidCache() {
        let invalidBank = ["invalid", "seed", "phrase"]
        let (sut, store) = makeSUT()
        
        store.completeRetrievalSuccessfully(with: invalidBank)
        
        let seed = try? sut.load()
        
        XCTAssertEqual(seed?.count, 0)
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    
    func test_load_deliversSeed() {
        let bank = seedBank()
        
        let (sut, store) = makeSUT()
        
        store.completeRetrievalSuccessfully(with: bank)
        let seed = try? sut.load()

        XCTAssertEqual(seed?.count, 24, "Seed count must be 24.")
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_hasNoSideEffectsOnDeliversSeed() {
        let bank = seedBank()
        
        let (sut, store) = makeSUT()
        
        store.completeRetrievalSuccessfully(with: bank)
        
        let seed = try? sut.load()
        
        XCTAssertEqual(seed?.count, 24, "Seed count must be 24.")
        XCTAssertEqual(store.receivedMessages, [.retrieve])
        
        let newSeed = try? sut.load()
        
        XCTAssertEqual(newSeed?.count, 24, "Seed count must be 24.")
        XCTAssertEqual(store.receivedMessages, [.retrieve, .retrieve])
        
        XCTAssertNotEqual(seed, newSeed)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalSeedLoader, store: SeedBankStoreSpy) {
        let store = SeedBankStoreSpy()
        let sut = LocalSeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalSeedLoader, toCompleteWith expectedResult: Result<[DomainSeed], Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        action()
        
        let receivedResult = Result { try sut.load() }
        
        switch (receivedResult, expectedResult) {
        case let (.success(receivedBank), .success(expectedSeed)):
            XCTAssertEqual(receivedBank, expectedSeed, file: file, line: line)
                
        case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
    
}
