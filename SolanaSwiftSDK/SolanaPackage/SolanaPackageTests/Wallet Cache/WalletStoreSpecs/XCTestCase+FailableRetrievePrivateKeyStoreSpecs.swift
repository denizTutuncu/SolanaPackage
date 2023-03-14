//
//  XCTestCase+FailableRetrieveWalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import XCTest
import SolanaPackage

extension FailableRetrievePrivateKeyStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(publicKey: PublicKey, on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(publicKey, sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(publicKey: PublicKey, on sut: KeychainPrivateKeyStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(publicKey, sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}


