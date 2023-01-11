//
//  SolanaClusterRPCEndpoints.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import Foundation

public enum BalanceEndpoint {
    case get(walletAddress: String)
    
    public func url(baseURL: URL) throws -> URLRequest {
        switch self {
        case let .get(walletAddress):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            
            var urlRequest = URLRequest(url: components.url!)
            urlRequest.httpMethod = "POST"
            
            struct GetBalanceRequest: Encodable {
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
                case url
                case encoder
                
                public var errorDescription: String? {
                    switch self {
                    case .publicKey:
                        return "There is no public address to connect."
                    case .url:
                        return "There is no URL to connect. We are unable to connect and we are working on it!"
                    case .encoder:
                        return "There is a problem with URL request body. We are unable to connect and we are working on it!"
                    }
                }
            }
            
            let requestBody = GetBalanceRequest(params: [walletAddress])
            
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
