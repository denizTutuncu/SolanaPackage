//
//  RemoteLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 5/24/22.
//

import Foundation

public final class RemoteLoader<Resource> {
    private let url: URL?
    private let publicAddress: String
    private let client: HTTPClient
    private let urlRequestMapper: URLRequestMapper
    private let responseMapper: ResponseMapper
    
    public enum Error: Swift.Error, LocalizedError {
        case emptyURL
        case badURL
        case invalidData
        
        public var errorDescription: String? {
            switch self {
            case .emptyURL:
                return "The URL we use to connect with Solana blockchain is empty. We are unable to connect and we are working on it!"
            case .badURL:
                return "The URL we use to connect with Solana blockchain is unexpected. We are unable to connect and we are working on it!"
            case .invalidData:
                return "Solana blockchain sent us an unexpected data structure.  We are unable to parse the data and we are working on it!"
            }
        }
    }
    
    public typealias RequestResult = Swift.Result<URLRequest, Swift.Error>
    public typealias URLRequestMapper = (URL?, String?) throws -> URLRequest
    
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias ResponseMapper = (Data, HTTPURLResponse) throws -> Resource
  
    public init(url: URL?, publicAddress: String, client: HTTPClient, urlRequestMapper: @escaping URLRequestMapper, mapper: @escaping ResponseMapper) {
        self.url = url
        self.publicAddress = publicAddress
        self.client = client
        self.urlRequestMapper = urlRequestMapper
        self.responseMapper = mapper
    }
        
    public func load(completion: @escaping (Result) -> Void) {
        guard let url = url, !url.absoluteString.isEmpty else { completion(.failure(Error.emptyURL)); return }
        
        switch self.mapURLRequest(url, publicAddress) {
        case let .success(urlRequest):
            client.get(from: urlRequest) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success((data, response)):
                    completion(self.map(data, from: response))
                case .failure:
                    completion(.failure(Error.badURL))
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
    
    private func mapURLRequest(_ url: URL?, _ publicAddress: String?) -> RequestResult {
        do {
            return .success(try urlRequestMapper(url, publicAddress))
        } catch let (error) {
            return .failure(error)
        }
    }
}
