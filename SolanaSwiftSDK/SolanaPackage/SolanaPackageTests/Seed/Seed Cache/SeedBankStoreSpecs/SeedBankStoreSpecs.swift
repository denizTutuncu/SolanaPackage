//
//  SeedBankStoreSpecs.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/16/23.
//

import Foundation

protocol SeedBankStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache()
    func test_retrieve_hasNoSideEffectsOnEmptyCache()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()
}

protocol FailableRetrieveSeedBankStoreSpecs: SeedBankStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnFailure()
}

typealias FailableSeedBankStoreSpecss = FailableRetrieveSeedBankStoreSpecs
