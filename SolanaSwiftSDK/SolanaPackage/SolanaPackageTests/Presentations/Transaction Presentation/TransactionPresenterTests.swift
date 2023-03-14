//
//  TransactionPresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import XCTest
import SolanaPackage

class TransactionPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        let tableName = "Transaction"
        let key = "LIST_TITLE"
        XCTAssertEqual(TransactionPresenter.listTitle, localized(table: tableName, key: key))
    }
    
    func test_currencyName_isLocalized() {
        let tableName = "Transaction"
        let key = "LIST_SUBTITLE"
        XCTAssertEqual(TransactionPresenter.listSubtitle, localized(table: tableName, key: key))
    }
    
    // MARK: - Helpers
    
    private func localized(table: String, key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let bundle = Bundle(for: TransactionPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
    
}
