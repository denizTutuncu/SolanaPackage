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
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }
}
