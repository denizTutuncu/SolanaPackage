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
        XCTAssertEqual(WalletPresenter.walletListViewTitle, localized(table: "Wallet", key: "WALLET_TITLE"))
    }
    
    func test_subtitle_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListViewSubtitle, localized(table: "WalletListSubtitle", key:"WALLETLIST_SUBTITLE"))
    }
    
    func test_currencyName_isLocalized() {
        XCTAssertEqual(WalletPresenter.currency, localized(table: "CurrencyName", key:"CURRENCY_NAME"))
    }
    
    func test_networkName_isLocalized() {
        XCTAssertEqual(WalletPresenter.network, localized(table: "NetworkName", key:"NETWORK_NAME"))
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
