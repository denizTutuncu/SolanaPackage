//
//  BalanceURLRequestMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public final class BalanceURLRequestMapper {
    
    private struct GetBalanceRequest: Encodable {
        private let jsonrpc: String = "2.0"
        private let id: Int = 1
        private let method: String = "getBalance"
        private let params: [String] //publicKey
    
        init(params: [String]) {
            self.params = params
        }
    }
    
    private enum Error: Swift.Error, LocalizedError {
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
    
    public static func map(_ url: URL?, _ publicKey: String?) throws -> URLRequest {
        guard let publicKey = publicKey, !publicKey.isEmpty else {
            throw Error.publicKey
        }
        
        guard let baseURL = url else { throw Error.url }
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        
        let requestBody = GetBalanceRequest(params: [publicKey])
        
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
