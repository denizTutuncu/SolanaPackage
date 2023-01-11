//
//  HTTPClient.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/18/22.
//

import Foundation


public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The completion handler can be invoked in any tread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from urlRequest: URLRequest, completion: @escaping (Result) -> Void) -> HTTPClientTask
}


