//
//  GetSolAccInfoRequest.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/26/22.
//

import Foundation

public struct GetBalanceRequest: Encodable {
    public let jsonrpc: String = "2.0"
    public let id: Int = 1
    public let method: String = "getBalance"
    public let params: [String] //publicKey
    
    public init(params: [String]) {
        self.params = params
    }
}
