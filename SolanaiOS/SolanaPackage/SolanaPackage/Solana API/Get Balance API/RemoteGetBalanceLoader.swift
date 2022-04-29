//
//  RemoteGetSolAccountInfoLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

public final class RemoteGetBalanceLoader: GetBalanceLoader {
    private let client: HTTPClient
    private let urlMaker: GetBalanceRequestMaker
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
        case badRequest
    }
    
    public typealias Result = GetBalanceLoader.Result
    
    public init(client: HTTPClient, urlMaker: GetBalanceRequestMaker) {
        self.client = client
        self.urlMaker = urlMaker
    }
    
    public func perform(pubKey: String?, completion: @escaping (Result) -> Void) {
        urlMaker.getURLRequest(pubKey: pubKey) { [weak self] result in
            switch result {
            case let .success(urlRequest):
                self?.client.send(urlRequest) { [weak self] result in
                    guard self != nil else { return }
                    switch result {
                    case let .success((data, response)):
                        completion(RemoteGetBalanceLoader.map(data, from: response))
                    case .failure:
                        completion(.failure(Error.connectivity))
                    }
                }

            case .failure:
                completion(.failure(Error.badRequest))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let remoteResponse = try GetBalanceResponseMapper
                .map(data, from: response)
            return .success(
                GetBalanceResponse(jsonrpc:  remoteResponse.jsonrpc,
                                   result: GetBalanceResult(context: GetBalanceContext(slot: remoteResponse.result.context.slot), value: remoteResponse.result.value),
                                      id: remoteResponse.id)
            )
        } catch {
            return .failure(error)
        }
    }
    
}
