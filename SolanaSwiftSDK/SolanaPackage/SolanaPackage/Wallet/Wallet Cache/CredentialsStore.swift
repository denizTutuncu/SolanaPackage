//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public typealias PublicKey = String
public typealias PrivateKey = String

public protocol CredentialsStore {
    func insert(publicKey: PublicKey, privateKey: PrivateKey) throws
    func privateKey(for publicKey: PublicKey) throws -> PrivateKey
    func deletePrivateKey(for publicKey: PublicKey) throws
}
