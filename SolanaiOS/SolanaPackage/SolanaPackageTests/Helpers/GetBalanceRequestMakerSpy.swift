//
//  GetBalanceRequestMakerSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/28/22.
//

import Foundation
import SolanaPackage

class GetBalanceRequestMakerSpy: GetBalanceRequestMaker {
    let jsonrpc: String = "2.0"
    let id: Int = 1
    let method: String = "getBalance"
    
    private var messages = [(GetBalanceRequestMaker.Result) -> Void]()
    
    func getURLRequest(pubKey: String?, completion: @escaping (GetBalanceRequestMaker.Result) -> Void) {
        messages.append(completion)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index](.failure(error))
    }
    
    func complete(request: URLRequest, at index: Int = 0) {
        messages[index](.success(request))
    }
}
