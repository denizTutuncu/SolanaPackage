//
//  SolanaPackageCacheIntegrationTests.swift
//  SolanaPackageCacheIntegrationTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

final class SolanaPackagePublicKeyCacheIntegrationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }
        
    func test_loadPublicKeys_deliversNoItemsOnEmptyCache() {
        let publicKeysLoader = makePublicKeyLoader()
        
        expect(publicKeysLoader, toLoad: [])
    }
    
    func test_loadPublicKeys_deliversItemsSavedOnASeparateInstance() {
        let publicKeyLoaderToPerformSave = makePublicKeyLoader()
        let publicKeyLoaderToPerformLoad = makePublicKeyLoader()
        let publicKeys = uniquePublicKeys()
        
        save(publicKeys, with: publicKeyLoaderToPerformSave)
        
        expect(publicKeyLoaderToPerformLoad, toLoad: publicKeys)
    }
    
    func test_savePublicKeys_overridesItemsSavedOnASeparateInstance() {
        let publicKeysLoaderToPerformFirstSave = makePublicKeyLoader()
        let publicKeysLoaderToPerformLastSave = makePublicKeyLoader()
        let publicKeysLoaderToPerformLoad = makePublicKeyLoader()
        let firstPublicKeys = uniquePublicKeys()
        
        var latestPublicKeys: [String] = []
        latestPublicKeys.append(anotherUniquePublicKey())
        latestPublicKeys += firstPublicKeys
        
        save(firstPublicKeys, with: publicKeysLoaderToPerformFirstSave)
        save(latestPublicKeys, with: publicKeysLoaderToPerformLastSave)

        expect(publicKeysLoaderToPerformLoad, toLoad: latestPublicKeys)
    }

    func test_validateFeedCache_doesNotDeleteRecentlySavedPublicKey() {
        let publicKeyLoaderToPerformSave = makePublicKeyLoader()
        let publicKeyLoaderToPerformValidation = makePublicKeyLoader()
        let firstPublicKeys = uniquePublicKeys()

        save(firstPublicKeys, with: publicKeyLoaderToPerformSave)
        validateCache(with: publicKeyLoaderToPerformValidation)

        expect(publicKeyLoaderToPerformSave, toLoad: firstPublicKeys)
    }

    func test_validateFeedCache_doesNotDeletePublicKeysSavedInADistantPast() {
        let publicKeyLoaderToPerformSave = makePublicKeyLoader(currentDate: .distantPast)
        let publicKeyLoaderToPerformValidation = makePublicKeyLoader(currentDate: Date())
        let publicKeys = uniquePublicKeys()

        save(publicKeys, with: publicKeyLoaderToPerformSave)
        validateCache(with: publicKeyLoaderToPerformValidation)

        expect(publicKeyLoaderToPerformSave, toLoad: uniquePublicKeys())
    }

    // MARK: - Helpers
    
    private func makePublicKeyLoader(currentDate: Date = Date(), file: StaticString = #filePath, line: UInt = #line) -> LocalPublicKeyLoader {
        let storeURL = testSpecificStoreURL()
        let store = try! CodablePublicKeyStore(storeURL: storeURL)
        let sut = LocalPublicKeyLoader(store: store, currentDate: { currentDate })
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func save(_ publicKeys: [String], with loader: LocalPublicKeyLoader, file: StaticString = #filePath, line: UInt = #line) {
        do {
            try loader.save(publicKeys)
        } catch {
            XCTFail("Expected to save image data successfully, got error: \(error)", file: file, line: line)
        }
    }

    private func validateCache(with loader: LocalPublicKeyLoader, file: StaticString = #filePath, line: UInt = #line) {
        do {
            try loader.validateCache()
        } catch {
            XCTFail("Expected to validate feed successfully, got error: \(error)", file: file, line: line)
        }
    }
    
    private func expect(_ sut: LocalPublicKeyLoader, toLoad expectedPublicKeys: [String], file: StaticString = #filePath, line: UInt = #line) {
        do {
            let loadedPublicKeys = try sut.load()
            XCTAssertEqual(loadedPublicKeys, expectedPublicKeys, file: file, line: line)
        } catch {
            XCTFail("Expected successful feed result, got \(error) instead", file: file, line: line)
        }
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
    
    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

}
