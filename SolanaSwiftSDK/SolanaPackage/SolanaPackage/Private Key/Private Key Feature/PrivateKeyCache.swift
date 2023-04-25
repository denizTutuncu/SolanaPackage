//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public protocol PrivateKeyCache {
    func save(_ publicKey: String, privateKey: String) throws
}
