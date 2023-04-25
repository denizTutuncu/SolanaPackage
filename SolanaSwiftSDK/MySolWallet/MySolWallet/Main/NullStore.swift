//
//  PublicKeyNullStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 4/22/23.
//

import Foundation
import SolanaPackage

class NullStore {}

extension NullStore: PublicKeyStore {
    func insert(_ publicKeys: [String], timestamp: Date) throws {}
    func retrieve() throws -> CachedPublicKey? { return .none }
    func deleteCached(_ publicKeys: [String]) throws {}
}

extension NullStore: PrivateKeyStore {
    func insert(publicKey: PublicKey, privateKey: PrivateKey) throws {}
    func privateKey(for publicKey: PublicKey) throws -> PrivateKey? { return .none }
    func deletePrivateKey(for publicKey: PublicKey) throws {}
}
