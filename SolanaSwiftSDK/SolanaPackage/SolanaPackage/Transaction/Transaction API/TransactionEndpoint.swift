//
//  TransactionEndpoint.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/14/25.
//

import Foundation

public enum TransactionEndpoint {
    case get(publicKey: String)
    
    public func url(baseURL: URL) throws -> URLRequest {
        switch self {
        case let .get(walletAddress):
            guard !walletAddress.isEmpty else { throw Error.publicKey }
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            
            var urlRequest = URLRequest(url: components.url!)
            urlRequest.httpMethod = "POST"
            
            struct GetTransactionRequest: Encodable {
                private let jsonrpc: String = "2.0"
                private let id: Int = 1
                private let method: String = "getBalance"
                private let params: [String] //publicKey
                
                init(params: [String]) {
                    self.params = params
                }
            }
            
            enum Error: Swift.Error, LocalizedError {
                case publicKey
                case encoder
                
                public var errorDescription: String? {
                    switch self {
                    case .publicKey:
                        return "There is no public address to connect."
                    case .encoder:
                        return "There is a problem with URL request body. We are unable to connect and we are working on it!"
                    }
                }
            }
            
            let requestBody = GetTransactionRequest(params: [walletAddress])
            
            do {
                let jsonData = try JSONEncoder().encode(requestBody)
                urlRequest.httpBody = jsonData
            } catch {
                throw Error.encoder
            }
            
            let headers = ["Content-Type":"application/json"]
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
            return urlRequest
        }
    }
}
