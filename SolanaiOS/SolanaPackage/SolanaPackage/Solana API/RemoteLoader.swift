//
//  RemoteLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/24/22.
//

import Foundation

public final class RemoteLoader<Resource> {
    private let url: URL?
    private let publicKey: String
    private let client: HTTPClient
    private let urlRequestMapper: URLRequestMapper
    private let responseMapper: ResponseMapper
    
    public enum Error: Swift.Error {
        case badURL
        case badURLRequest
        case connectivity
        case invalidData
    }
    
    public typealias RequestResult = Swift.Result<URLRequest, Swift.Error>
    public typealias URLRequestMapper = (URL?, String?) throws -> URLRequest
    
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias ResponseMapper = (Data, HTTPURLResponse) throws -> Resource
  
    public init(url: URL?, publicKey: String, client: HTTPClient, urlRequestMapper: @escaping URLRequestMapper, mapper: @escaping ResponseMapper) {
        self.url = url
        self.publicKey = publicKey
        self.client = client
        self.urlRequestMapper = urlRequestMapper
        self.responseMapper = mapper
    }
        
    public func load(completion: @escaping (Result) -> Void) {
        guard let url = url, !url.absoluteString.isEmpty else { completion(.failure(Error.badURL)); return }
        
        switch self.mapURLRequest(url, publicKey: publicKey) {
        case let .success(urlRequest):
            client.get(from: urlRequest) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success((data, response)):
                    completion(self.map(data, from: response))
                case .failure:
                    completion(.failure(Error.connectivity))
                }
            }
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            return .success(try responseMapper(data, response))
        } catch {
            return .failure(Error.invalidData)
        }
    }
    
    private func mapURLRequest(_ url: URL?, publicKey: String?) -> RequestResult {
        do {
            return .success(try urlRequestMapper(url, publicKey))
        } catch {
            return .failure(Error.badURLRequest)
        }
    }
}
