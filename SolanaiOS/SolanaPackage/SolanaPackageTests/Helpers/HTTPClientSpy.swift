//
//  HTTPClientSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation
import SolanaPackage

class HTTPClientSpy: HTTPClient {
    
    private var messages = [(request: URLRequest, completion: (HTTPClient.Result) -> Void)]()
    
    var requests: [URLRequest] {
        return messages.map { $0.request }
    }
    
    func send(_ request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        messages.append((request, completion))
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(url: requests[index].url!, statusCode: code,
                                       httpVersion: nil,
                                       headerFields: nil)!
        messages[index].completion(.success((data, response)))
    }
}

