//
//  XCTestCase+FailableDeleteWalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension FailableDeletePrivateKeyStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(_ publicKey: PublicKey, on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(publicKey, from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(_ publicKey: PublicKey, on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(publicKey, from: sut)
        
        expect(publicKey, sut, toRetrieve: .failure(deletionError!) , file: file, line: line)
    }
}

