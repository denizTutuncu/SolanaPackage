//
//  XCTestCase+FailableRetrievePublicKeyStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import XCTest
import SolanaPackage

extension FailableRetrievePublicKeyStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: PublicKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}

