//
//  XCTestCase+FailableInsertWalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension FailableInsertPrivateKeyStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        let insertionError = insert(publicKey, privateKey, to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        let publicKey = uniqueWallet().publicKey
        let privateKey = uniquePrivateKey()
        insert(publicKey, privateKey, to: sut)
        
        expect(publicKey, sut, toRetrieve: .success(privateKey), file: file, line: line)
    }
}

