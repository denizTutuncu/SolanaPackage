//
//  BalanceResponse.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public struct BalanceResponse: Equatable {
    public let jsonrpc: String
    public let result: BalanceResult
    public let id: Int
    public init(jsonrpc: String, result: BalanceResult, id: Int) {
        self.jsonrpc = jsonrpc
        self.result = result
        self.id = id
    }
}

public struct BalanceResult: Equatable {
    public let context: BalanceContext
    public let value: Int
    public init(context: BalanceContext, value: Int) {
        self.context = context
        self.value = value
    }
}

public struct BalanceContext: Equatable {
    public let slot: Int
    public init(slot: Int) {
        self.slot = slot
    }
}
