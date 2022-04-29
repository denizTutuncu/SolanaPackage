//
//  RemoteGetSolAccInfoResult.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

internal struct RemoteGetBalanceResponse: Codable {
    let jsonrpc: String
    let result: RemoteGetBalanceResult
    let id: Int
}

internal struct RemoteGetBalanceResult: Codable {
    let context: RemoteGetBalanceContext
    let value: Int
}

internal struct RemoteGetBalanceContext: Codable {
    let slot: Int
}
