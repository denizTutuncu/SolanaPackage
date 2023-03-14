//
//  SharedTestHelpers.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/20/22.
//

import Foundation
import SolanaPackage

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

func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["items": items]
    return try! JSONSerialization.data(withJSONObject: json)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
    
    func adding(minutes: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(days: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
}

func uniqueWallet() -> DomainWallet {
    return DomainWallet(id: UUID(), publicKey: "Unique Public Key")
}

func uniquePrivateKey() -> String {
    return "Unique Private Key"
}
