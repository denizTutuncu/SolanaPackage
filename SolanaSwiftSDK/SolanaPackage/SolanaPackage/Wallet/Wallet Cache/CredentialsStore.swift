//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public protocol CredentialsStore {
    typealias PublicKey = String
    typealias PrivateKey = String

    func insert(publicKey: PublicKey, privateKey: PrivateKey) throws
    func privateKey(for publicKey: PublicKey) throws -> PrivateKey
    func deletePrivateKey(for publicKey: PublicKey) throws
}
