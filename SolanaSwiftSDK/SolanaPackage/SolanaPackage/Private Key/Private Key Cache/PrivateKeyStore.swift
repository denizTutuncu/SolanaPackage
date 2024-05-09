//
//  WalletCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public protocol PrivateKeyStore {
    typealias PublicKey = String
    typealias PrivateKey = Data

    func store(publicKey: PublicKey, privateKey: PrivateKey) throws
    func read(for publicKey: PublicKey) throws -> PrivateKey?
    func deleteKey(for publicKey: PublicKey) throws
}
