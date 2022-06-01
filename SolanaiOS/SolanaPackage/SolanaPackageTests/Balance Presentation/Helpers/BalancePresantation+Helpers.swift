//
//  BalancePresantation+Helpers.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 5/31/22.
//

import SolanaPackage

func uniqueBalance() -> BalanceResponse {
    return BalanceResponse(jsonrpc: "2.0", result: BalanceResult(context: BalanceContext(slot: 124067037), value: 25000000000), id: 1)
}
