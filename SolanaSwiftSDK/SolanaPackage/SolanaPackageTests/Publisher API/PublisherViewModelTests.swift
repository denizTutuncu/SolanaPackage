//
//  PublisherViewModelTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/3/23.
//

import XCTest
import SolanaPackage

class PublisherViewModelTests: XCTestCase {
    
    func test_SUTNotNil() {
        let sut = sut()
        XCTAssertNotNil(sut)
    }
    
    func test_SUTLoadingTrueWhenSUTInitilazed() {
        let sut = sut()
        
        XCTAssertTrue(sut.onLoadingState)
        XCTAssertEqual(sut.onResourceLoad, nil)
    }
    
    
    func test_SUTLoadingFalseWhenSUTReturns() {
        let sut = sut()
        
        sut.load()
        XCTAssertFalse(sut.onLoadingState)
        XCTAssertEqual(sut.onResourceLoad, 13)
    }
    
    private func sut() -> ViewModelPublisher<String, Int> {
        let resource = "Test Resource"
        let mapper: (String) throws -> Int = { string in
            return string.count
        }
        return ViewModelPublisher(resource: resource, mapper: mapper)
    }
}
