//
//  WalletPresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

class WalletPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        XCTAssertEqual(WalletPresenter.title, localized(table: "Wallets", key: "WALLET_TITLE"))
    }
    
    func test_currencyName_isLocalized() {
        XCTAssertEqual(WalletPresenter.currencyName, localized(table: "CurrencyName", key:"CURRENCY_NAME"))
    }
    
    // MARK: - Helpers
    
    private func localized(table: String, key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let bundle = Bundle(for: WalletPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
    
}
