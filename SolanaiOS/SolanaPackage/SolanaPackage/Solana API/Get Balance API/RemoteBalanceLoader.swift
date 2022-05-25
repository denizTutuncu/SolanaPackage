//
//  RemoteGetSolAccountInfoLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

extension RemoteLoader: BalanceLoader where Resource == BalanceResponse {}

public typealias RemoteBalanceLoader = RemoteLoader<BalanceResponse>

public extension RemoteBalanceLoader {
    convenience init(url: URL?, publicKey: String, client: HTTPClient) {
        self.init(url: url, publicKey: publicKey, client: client, urlRequestMapper: BalanceURLRequestMapper.map, mapper: BalanceResponseMapper.map)
    }
}

