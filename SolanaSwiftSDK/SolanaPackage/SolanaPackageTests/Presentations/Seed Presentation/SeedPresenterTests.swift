//
//  SeedPresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import XCTest
import SolanaPackage

class SeedPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        let tableName = "Seed"
        let key = "SEED_LIST_TITLE"
        XCTAssertEqual(SeedPresenter.title, localized(table: tableName, key: key))
    }
    
    func test_currencyName_isLocalized() {
        let tableName = "Seed"
        let key = "SEED_LIST_SUBTITLE"
        XCTAssertEqual(SeedPresenter.subtitle, localized(table: tableName, key: key))
    }
    
    // MARK: - Helpers
    
    private func localized(table: String, key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let bundle = Bundle(for: SeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
    
}
