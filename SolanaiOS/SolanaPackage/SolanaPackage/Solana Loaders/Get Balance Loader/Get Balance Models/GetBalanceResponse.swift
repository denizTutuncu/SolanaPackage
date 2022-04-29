//
//  GetSolAccInfoResponse.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public struct GetBalanceResponse: Equatable {
    public let jsonrpc: String
    public let result: GetBalanceResult
    public let id: Int
    public init(jsonrpc: String, result: GetBalanceResult, id: Int) {
        self.jsonrpc = jsonrpc
        self.result = result
        self.id = id
    }
}

public struct GetBalanceResult: Equatable {
    public let context: GetBalanceContext
    public let value: Int
    public init(context: GetBalanceContext, value: Int) {
        self.context = context
        self.value = value
    }
}

public struct GetBalanceContext: Equatable {
    public let slot: Int
    public init(slot: Int) {
        self.slot = slot
    }
}
