//
//  BalanceResponseMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

public final class BalanceItemMapper {
    
    private struct Root: Decodable {
        private let jsonrpc: String
        private let result: RemoteBalanceResult
        private let id: Int
        
        private struct RemoteBalanceResult: Decodable {
            let context: RemoteBalanceContext
            let value: Int
        }

        private struct RemoteBalanceContext: Decodable {
            let slot: Int
        }
    
        var response: Balance {
            Balance(amount: result.value)
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Balance {
        guard isOK(response),
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.response
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
    
}
