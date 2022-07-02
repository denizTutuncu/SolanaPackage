//
//  BalanceLocalizationTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import XCTest
import SolanaPackage

final class BalanceLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Balance"
        let bundle = Bundle(for: BalanceViewModel.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}

