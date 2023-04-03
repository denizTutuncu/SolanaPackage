//
//  XCTestCase+SeedBankStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/16/23.
//

import XCTest
import SolanaPackage

extension SeedBankStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .success([]), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .success([]), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        let bank = seedBank()
        load(to: sut)
        
        expect(sut, toRetrieve: .success(bank), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        let bank = seedBank()
        
        load(to: sut)
        
        expect(sut, toRetrieveTwice: .success(bank), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        load(to: sut)
     
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }
}

extension SeedBankStoreSpecs where Self: XCTestCase {
    @discardableResult
    func load(to sut: SeedBankStore) -> Error? {
        do {
            let _ = try sut.loadBank()
            return nil
        } catch {
            return error
        }
    }
    
    func expect(_ sut: SeedBankStore, toRetrieveTwice expectedResult: Result<[String], Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: SeedBankStore, toRetrieve expectedResult: Result<[String], Error>, file: StaticString = #filePath, line: UInt = #line) {
        let retrievedResult = Result { try sut.loadBank() }
        
        switch (expectedResult, retrievedResult) {
        case (.success([]), .success([])),
             (.failure, .failure):
            break
            
        case let (.success(expected), .success(retrieved)):
            XCTAssertEqual(retrieved, expected, file: file, line: line)
            
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
}

