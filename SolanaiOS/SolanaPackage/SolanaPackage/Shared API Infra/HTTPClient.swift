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

//Move to iOS App module when you create iOS App module
import Combine
public extension HTTPClient {
    typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
    
    func getPublisher(urlRequest: URLRequest) -> Publisher {
        var task: HTTPClientTask?
        
        return Deferred {
            Future { completion in
                task = self.get(from: urlRequest, completion: completion)
            }
        }
        .handleEvents(receiveCancel: { task?.cancel() })
        .eraseToAnyPublisher()
    }
}
