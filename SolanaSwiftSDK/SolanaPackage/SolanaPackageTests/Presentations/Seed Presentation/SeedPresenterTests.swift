//
//  SeedPresenterTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import XCTest
import SolanaPackage

class SeedPresenterTests: XCTestCase {
    
    // MARK: - Import Seed View
    func test_importSeedViewTitle_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_TITLE"
        XCTAssertEqual(SeedPresenter.importSeedViewTitle, localized(table: tableName, key: key))
    }
    
    func test_importSeedViewSubtitle_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_SUBTITLE"
        XCTAssertEqual(SeedPresenter.importSeedViewSubtitle, localized(table: tableName, key: key))
    }
    
    func test_importSeedViewButtonTitle_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_BUTTON_TITLE"
        XCTAssertEqual(SeedPresenter.importSeedViewButtonTitle, localized(table: tableName, key: key))
    }
    
    func test_importSeedViewErrorMessage_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_ERROR_MESSAGE"
        XCTAssertEqual(SeedPresenter.importSeedViewErrorMessage, localized(table: tableName, key: key))
    }
    
    func test_importSeedViewErrorButtonTitle_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_ERROR_BUTTON_TITLE"
        XCTAssertEqual(SeedPresenter.importSeedViewErrorButtonTitle, localized(table: tableName, key: key))
    }
    
    func test_importSeedViewLoadingTitle_isLocalized() {
        let tableName = "Seed"
        let key = "IMPORT_SEED_VIEW_LOADING_TITLE"
        XCTAssertEqual(SeedPresenter.importSeedViewLoadingTitle, localized(table: tableName, key: key))
    }
    
    // MARK: - Export Seed View
    func test_exportSeedViewTitle_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_TITLE"
        XCTAssertEqual(SeedPresenter.exportSeedViewTitle, localized(table: tableName, key: key))
    }
    
    func test_exportSeedViewSubtitle_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_SUBTITLE"
        XCTAssertEqual(SeedPresenter.exportSeedViewSubtitle, localized(table: tableName, key: key))
    }
    
    func test_exportSeedViewButtonTitle_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_BUTTON_TITLE"
        XCTAssertEqual(SeedPresenter.exportSeedViewButtonTitle, localized(table: tableName, key: key))
    }
    
    func test_exportSeedViewErrorMessage_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_ERROR_MESSAGE"
        XCTAssertEqual(SeedPresenter.exportSeedViewErrorMessage, localized(table: tableName, key: key))
    }
    
    func test_exportSeedViewErrorButtonTitle_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_ERROR_BUTTON_TITLE"
        XCTAssertEqual(SeedPresenter.exportSeedViewErrorButtonTitle, localized(table: tableName, key: key))
    }
    
    func test_exportSeedViewLoadingTitle_isLocalized() {
        let tableName = "Seed"
        let key = "EXPORT_SEED_VIEW_LOADING_TITLE"
        XCTAssertEqual(SeedPresenter.exportSeedViewLoadingTitle, localized(table: tableName, key: key))
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
