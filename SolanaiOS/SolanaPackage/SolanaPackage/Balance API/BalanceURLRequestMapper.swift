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
        private let method: String //= "getBalance"
        private let params: [String] //publicKey
    
        init(method: String, params: [String]) {
            self.method = method
            self.params = params
        }
    }
    
    private enum Error: Swift.Error {
        case publicKey
        case methodName
        case url
        case encoder
    }
    
    public static func map(_ url: URL?, _ methodName: String?, _ publicKey: String?) throws -> URLRequest {
        guard let publicKey = publicKey, !publicKey.isEmpty else {
            throw Error.publicKey
        }
        
        guard let methodName = methodName else { throw Error.methodName }
        
        guard let baseURL = url else { throw Error.url }
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        
        let requestBody = GetBalanceRequest(method: methodName, params: [publicKey])
        
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
