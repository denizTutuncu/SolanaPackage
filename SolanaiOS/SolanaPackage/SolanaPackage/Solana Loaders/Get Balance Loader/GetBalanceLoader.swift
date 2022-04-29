//
//  GetSolAccountService.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/18/22.
//

import Foundation

public protocol GetBalanceLoader {
    typealias Result = Swift.Result<GetBalanceResponse, Error>
    func perform(pubKey: String?, completion: @escaping (Result) -> Void)
}
