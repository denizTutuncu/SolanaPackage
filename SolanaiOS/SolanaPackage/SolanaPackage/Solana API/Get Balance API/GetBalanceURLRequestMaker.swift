//
//  GetSolAccountInfoRequestLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public class GetBalanceURLRequestMaker: GetBalanceRequestMaker {
    private let rpcEndpoint: SolanaClusterRPCEndpoints
    
    private enum Error: Swift.Error {
        case publicKey
        case url
        case encoder
    }
    
    public init(rpcEndpoint: SolanaClusterRPCEndpoints) {
        self.rpcEndpoint = rpcEndpoint
    }
    
    public func getURLRequest(pubKey: String?, completion: @escaping (GetBalanceRequestMaker.Result) -> Void) {
        guard let pubKey = pubKey, !pubKey.isEmpty else {
            completion(.failure(Error.publicKey))
            return
        }
        guard let baseURL = URL(string: rpcEndpoint.rawValue) else { return completion(.failure(Error.url)) }
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        
        let requestBody = GetBalanceRequest(params: [pubKey])
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            urlRequest.httpBody = jsonData
        } catch {
            return completion(.failure(Error.encoder))
        }
        
        let headers = ["Content-Type":"application/json"]
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        completion(.success(urlRequest))
    }
}
