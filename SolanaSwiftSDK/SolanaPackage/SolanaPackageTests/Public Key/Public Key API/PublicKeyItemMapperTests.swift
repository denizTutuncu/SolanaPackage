//
//  PublicKeyItemMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/23/25.
//

import XCTest
import SolanaPackage

class PublicKeyItemMapperTests: XCTestCase {

    func test_map_returnsSamePublicKeysArray() throws {
        let publicKeys = ["key1", "key2", "key3"]

        let result = try PublicKeyItemsMapper.map(publicKeys)

        XCTAssertEqual(result, publicKeys)
    }

    func test_map_withEmptyArray_returnsEmptyArray() throws {
        let publicKeys: [String] = []

        let result = try PublicKeyItemsMapper.map(publicKeys)

        XCTAssertTrue(result.isEmpty)
    }

    func test_map_withSpecialCharactersInKeys_returnsSameArray() throws {
        let publicKeys = ["key1#", "key@2", "key$3"]

        let result = try PublicKeyItemsMapper.map(publicKeys)

        XCTAssertEqual(result, publicKeys)
    }

    func test_map_withLongPublicKeys_returnsSameArray() throws {
        let publicKeys = [
            String(repeating: "a", count: 64),
            String(repeating: "b", count: 128),
            String(repeating: "c", count: 256)
        ]

        let result = try PublicKeyItemsMapper.map(publicKeys)

        XCTAssertEqual(result, publicKeys)
    }
}
