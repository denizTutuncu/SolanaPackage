//
//  XCTestCase+FailableInsertWalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension FailableInsertWalletStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueWalletFeed().local, Date()), to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: WalletStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueWalletFeed().local, Date()), to: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}

