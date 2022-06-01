//
//  HTTPClientSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation
import SolanaPackage

class HTTPClientSpy: HTTPClient {
    private struct Task: HTTPClientTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    private var messages = [(urlRequest: URLRequest, completion: (HTTPClient.Result) -> Void)]()
    private(set) var cancelledURLs = [URLRequest]()
    
    var requestedURLs: [URL] {
        return messages.map { $0.urlRequest.url ?? URL(string: "")! }
    }
    
    func get(from urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        messages.append((urlRequest, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(urlRequest)
        }
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}

