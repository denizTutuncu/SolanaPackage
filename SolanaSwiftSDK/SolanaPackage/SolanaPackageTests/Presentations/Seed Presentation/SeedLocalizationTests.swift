//
//  SeedLocalizationTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import XCTest
import SolanaPackage

final class SeedLocalizationTests: XCTestCase {
    
    func test_localizedStrings_For_Seed() {
        let table = "Seed"
        localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: table)
    }
    
    private func localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: String) {
        let bundle = Bundle(for: SeedPresenter.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
