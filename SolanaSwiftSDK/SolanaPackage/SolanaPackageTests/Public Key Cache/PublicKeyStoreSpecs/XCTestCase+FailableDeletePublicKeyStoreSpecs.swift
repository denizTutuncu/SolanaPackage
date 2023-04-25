//
//  XCTestCase+FailableDeletePublicKeyStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

extension FailableDeletePublicKeyStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(publicKeys: uniquePublicKeys(), from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        deleteCache(publicKeys: uniquePublicKeys(), from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}
