//
//  LoadBalanceResponseMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/24/22.
//

import XCTest
import SolanaPackage

class LoadBalanceResponseMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let validResponse = makeResponseItem(jsonrpc: "2.0", slot: 124067037, value: 25000000000, id: 1)
        let json = validResponse.json
        let data = makeJSONData(json)
        let samples = [150, 199, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try BalanceResponseMapper.map(data, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try BalanceResponseMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyData = makeJSONData([:])
        XCTAssertThrowsError(
            try BalanceResponseMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversResponseOn200HTTPResponseWithJSON() throws {
        let validResponse = makeResponseItem(jsonrpc: "2.0", slot: 124067037, value: 25000000000, id: 1)
        let json = validResponse.json
        let data = makeJSONData(json)
        
        let result = try BalanceResponseMapper.map(data, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, validResponse.model)
    }
    
    
    private func makeResponseItem(jsonrpc: String, slot: Int, value: Int, id: Int) -> (model: Balance, json: [String:Any]) {
        let model = Balance(lamports: value)
        let json: [String:Any] = [
            "jsonrpc": jsonrpc,
            "result": [
                "context": [
                    "slot": slot
                ],
                "value": value
            ],
            "id": id
        ].compactMapValues { $0 }
        
        return (model, json)
    }
    
    private func makeJSONData(_ item: [String:Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: item)
    }
    
}

private extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
