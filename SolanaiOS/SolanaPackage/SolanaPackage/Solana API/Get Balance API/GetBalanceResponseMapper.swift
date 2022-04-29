//
//  GetSolAccInfoResponseMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import Foundation

final class GetBalanceResponseMapper {
        
    private static var OK_Response: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> RemoteGetBalanceResponse {
        
        guard response.isOK, let root = try? JSONDecoder().decode(RemoteGetBalanceResponse.self, from: data) else {
            throw RemoteGetBalanceLoader.Error.invalidData
        }
        return root
    }
}
