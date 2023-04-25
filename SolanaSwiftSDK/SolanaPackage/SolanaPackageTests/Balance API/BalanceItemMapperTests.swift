//
//  LoadBalanceResponseMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/24/22.
//

import XCTest
import SolanaPackage

class BalanceItemMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let validResponse = makeResponseItem(jsonrpc: "2.0", slot: 124067037, value: 25000000000, id: 1)
        let json = validResponse.json
        let data = makeJSONData(json)
        let samples = [150, 199, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try BalanceItemMapper.map(data, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try BalanceItemMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyData = makeJSONData([:])
        XCTAssertThrowsError(
            try BalanceItemMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversResponseOn200HTTPResponseWithJSON() throws {
        let validResponse = makeResponseItem(jsonrpc: "2.0", slot: 124067037, value: 25000000000, id: 1)
        let json = validResponse.json
        let data = makeJSONData(json)
        
        let result = try BalanceItemMapper.map(data, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, validResponse.model)
    }
    
    private func makeResponseItem(jsonrpc: String, slot: Int, value: Double, id: Int) -> (model: Balance, json: [String:Any]) {
        let model = Balance(amount: value)
        let json: [String:Any] = [
            "jsonrpc": jsonrpc,
            "result": [
                "context": [
                    "slot": slot
                ],
                "value": value
            ] as [String : Any],
            "id": id
        ]as [String:Any]
        
        return (model, json)
    }
    
    private func makeJSONData(_ item: [String:Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: item)
    }
    
}
