//
//  GetBalanceRequestMaker.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import Foundation

public protocol GetBalanceRequestMaker {
    typealias Result = Swift.Result<URLRequest, Swift.Error>
    func getURLRequest(pubKey: String?, completion: @escaping (Result) -> Void)
}
