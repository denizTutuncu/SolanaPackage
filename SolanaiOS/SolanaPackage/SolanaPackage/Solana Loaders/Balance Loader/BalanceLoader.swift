//
//  BalanceLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/18/22.
//

import Foundation

public protocol BalanceLoader {
    typealias Result = Swift.Result<BalanceResponse, Error>
    func load(completion: @escaping (Result) -> Void)
}
