//
//  WalletStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

protocol PrivateKeyStoreSpecs {
    func test_retrieve_failsOnEmptyCache()
    func test_retrieve_hasNoSideEffectsOnEmptyCache()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()
    
    func test_insert_deliversNoError()
    func test_insert_doesNotOverridesPreviouslyInsertedCacheValue()
    func test_insert_doesNotOverridesPreviouslyInsertedCacheValues()
    
    func test_delete_deliversNoErrorOnEmptyCache()
    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_deliversNoErrorOnNonEmptyCache()
    func test_delete_emptiesInsertedCache()
}

protocol FailableRetrievePrivateKeyStoreSpecs: PrivateKeyStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnFailure()
}

protocol FailableInsertPrivateKeyStoreSpecs: PrivateKeyStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
    func test_insert_hasNoSideEffectsOnInsertionError()
}

protocol FailableDeletePrivateKeyStoreSpecs: PrivateKeyStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

typealias FailableWalletStoreSpecs = FailableRetrievePrivateKeyStoreSpecs & FailableInsertPrivateKeyStoreSpecs & FailableDeletePrivateKeyStoreSpecs
