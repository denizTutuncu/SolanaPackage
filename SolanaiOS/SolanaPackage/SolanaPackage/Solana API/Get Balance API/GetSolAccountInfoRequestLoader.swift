//
//  GetSolAccountInfoRequestLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public class GetSolAccountInfoURLRequestMaker: GetSolAccountInfoURLRequestLoader {

    private let publicKey: String
    private let request: GetSolAccInfoRequest
    public init(publicKey: String, request: GetSolAccInfoRequest) {
        self.publicKey = publicKey
        self.request = request
    }
        
    public func getURLRequest() -> GetSolAccountInfoURLRequestLoader.Result {
        let baseURL = URL(string: "https://api.devnet.solana.com")!
        var urlRequest = URLRequest(url: baseURL)
        
        urlRequest.httpMethod = "POST"
        
        let requestBody = GetSolAccInfoRequest(method: request.method, paramElement: request.paramElement)
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            urlRequest.httpBody = jsonData
        } catch let error {
            return .failure(error)
        }
        
        let headers = ["Content-Type":"application/json"]
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return .success(urlRequest)
        
    }
}
