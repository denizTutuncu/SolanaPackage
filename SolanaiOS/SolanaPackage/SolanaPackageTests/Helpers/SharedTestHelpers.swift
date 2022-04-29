//
//  SharedTestHelpers.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/20/22.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("Any data".utf8)
}

func testURLRequest() -> URLRequest {
    var urlRequest = URLRequest(url: anyURL())
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = anyData()
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return urlRequest
}

