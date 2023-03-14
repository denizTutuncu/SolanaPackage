//
//  TransactionLocalizationTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import XCTest
import SolanaPackage

final class TransactionLocalizationTests: XCTestCase {
    
    func test_localizedStrings_For_Transactions() {
        let table = "Transaction"
        localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: table)
    }
    
    private func localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: String) {
        let bundle = Bundle(for: TransactionPresenter.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
