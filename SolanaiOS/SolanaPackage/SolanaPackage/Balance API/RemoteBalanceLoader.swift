//
//  RemoteBalanceLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

public typealias RemoteBalanceLoader = RemoteLoader<Balance>

public extension RemoteBalanceLoader {
    convenience init(url: URL?, publicAddress: String, client: HTTPClient) {
        self.init(url: url, publicAddress: publicAddress, client: client, urlRequestMapper: BalanceURLRequestMapper.map, mapper: BalanceResponseMapper.map)
    }
}

