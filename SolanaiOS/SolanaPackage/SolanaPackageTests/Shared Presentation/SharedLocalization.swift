//
//  SharedLocalization.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 6/1/22.
//

import XCTest
import SolanaPackage

class SharedLocalization: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Balance"
        let bundle = Bundle(for: BalanceViewModel.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
