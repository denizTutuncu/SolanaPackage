//
//  XCTestCase+FailableRetrieveSeedBankStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/3/23.
//

import XCTest
import SolanaPackage

extension FailableRetrieveSeedBankStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: SeedBankStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}
