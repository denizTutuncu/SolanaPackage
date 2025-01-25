//
//  XCTestCase+FailableInsertPublicKeyStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

extension FailableInsertPublicKeyStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniquePublicKeys(), Date()), to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniquePublicKeys(), Date()), to: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}
