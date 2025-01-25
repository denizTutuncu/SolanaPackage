//
//  TransactionItemMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/23/25.
//

import XCTest
import SolanaPackage

class DomainTransactionItemMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let validResponse = makeResponseItem(
            date: "2025-01-23",
            from: "senderAddress",
            to: "receiverAddress",
            amount: "100.0",
            currencyName: "SOL",
            signature: "uniqueSignature"
        )
        let json = validResponse.json
        let data = makeJSONData(json)
        let samples = [150, 199, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try TransactionItemMapper.map(data, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)

        XCTAssertThrowsError(
            try TransactionItemMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyData = makeJSONData([:])

        XCTAssertThrowsError(
            try TransactionItemMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_map_deliversResponseOn200HTTPResponseWithJSON() throws {
        let validResponse = makeResponseItem(
            date: "2025-01-23",
            from: "senderAddress",
            to: "receiverAddress",
            amount: "100.0",
            currencyName: "SOL",
            signature: "uniqueSignature"
        )
        let json = validResponse.json
        let data = makeJSONData(json)

        let result = try TransactionItemMapper.map(data, from: HTTPURLResponse(statusCode: 200))

        XCTAssertEqual(result, validResponse.model)
    }

    private func makeResponseItem(date: String, from: String, to: String, amount: String, currencyName: String, signature: String) -> (model: [DomainTransaction], json: [String: Any]) {
        let model = [
            DomainTransaction(
                date: date,
                from: from,
                to: to,
                amount: amount,
                currencyName: currencyName,
                signature: signature
            )
        ]

        let json: [String: Any] = [
            "jsonrpc": "2.0",
            "result": [
                "context": [[
                    "date": date,
                    "from": from,
                    "to": to,
                    "amount": amount,
                    "currencyName": currencyName,
                    "signature": signature
                ]]
            ],
            "id": 1
        ]

        return (model, json)
    }

    private func makeJSONData(_ item: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: item)
    }
}
