//
//  BalancePresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/11/23.
//

import XCTest
import SolanaPackage

class BalancePresenterTests: XCTestCase {
    func test_title_isLocalized() {
        XCTAssertEqual(BalancePresenter.title, localized("BALANCE_VIEW_TITLE"))
    }
    
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Balance"
        let bundle = Bundle(for: BalancePresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
