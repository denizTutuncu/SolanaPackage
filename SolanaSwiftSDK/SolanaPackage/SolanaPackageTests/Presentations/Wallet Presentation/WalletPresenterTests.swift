//
//  WalletPresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

class WalletPresenterTests: XCTestCase {
    
    // MARK: - WALLET VIEW
    func test_currencyName_isLocalized() {
        XCTAssertEqual(WalletPresenter.currencyName, localized(table: "Wallet", key: "WALLET_VIEW_CURRENCY_NAME"))
    }
    
    
    func test_networkName_isLocalized() {
        XCTAssertEqual(WalletPresenter.networkName, localized(table: "Wallet", key:"WALLET_VIEW_NETWORK_NAME"))
    }
    
    //MARK: - WALLET LIST VIEW
    func test_walletListViewTitle_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListViewTitle, localized(table: "Wallet", key: "WALLET_LIST_VIEW_TITLE"))
    }
    
    func test_walletListViewSubtitle_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListViewSubtitle, localized(table: "Wallet", key:"WALLET_LIST_VIEW_SUBTITLE"))
    }
    
    func test_walletListViewErrorMessage_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListViewErrorMessage, localized(table: "Wallet", key:"WALLET_LIST_VIEW_ERROR_MESSAGE"))
    }
    
    func test_walletListErrorButtonTitle_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListErrorButtonTitle, localized(table: "Wallet", key:"WALLET_LIST_VIEW_ERROR_BUTTON_TITLE"))
    }
    
    func test_walletListViewLoadingTitle_isLocalized() {
        XCTAssertEqual(WalletPresenter.walletListViewLoadingTitle, localized(table: "Wallet", key:"WALLET_LIST_VIEW_LOADING_TITLE"))
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
