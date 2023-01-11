//
//  BalanceItemMapper.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/11/23.
//

import XCTest
import SolanaPackage

class BalanceItemMapperTests: XCTestCase {
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try BalanceItemMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
}
