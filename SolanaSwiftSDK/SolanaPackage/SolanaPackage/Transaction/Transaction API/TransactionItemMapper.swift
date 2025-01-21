//
//  TransactionItemMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/14/25.
//

import Foundation

public final class TransactionItemMapper {
    
    private struct Root: Decodable {
        private let jsonrpc: String
        private let result: RemoteTransactionResult
        private let id: Int
        
        private struct RemoteTransactionResult: Decodable {
            let context: [RemoteTransactionContext]
        }
        
        private struct RemoteTransactionContext: Decodable {
            let date: String
            let from: String
            let to: String
            let amount: String
            let currencyName: String
            let signature: String
        }
        
        var transactions: [DomainTransaction] {
            result.context.map {
                DomainTransaction(
                    date: $0.date,
                    from: $0.from,
                    to: $0.to,
                    amount: $0.amount,
                    currencyName: $0.currencyName,
                    signature: $0.signature
                )
            }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [DomainTransaction] {
        guard isOK(response),
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.transactions
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
}
