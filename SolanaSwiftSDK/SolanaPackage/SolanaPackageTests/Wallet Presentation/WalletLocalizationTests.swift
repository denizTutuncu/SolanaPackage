//
//  WalletLocalizationTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

final class WalletLocalizationTests: XCTestCase {
    
    func test_localizedStrings_For_Wallets() {
        let table = "Wallets"
        localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: table)
    }
    
    func test_localizedStrings_For_CurrencyNameCurrencyName() {
        let table = "CurrencyName"
        localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: table)
    }
    
    private func localizedStrings_haveKeysAndValuesForAllSupportedLocalizations(table: String) {
        let bundle = Bundle(for: WalletPresenter.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
