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
    func store(publicKey: PublicKey, privateKey: PrivateKey) throws {}
    func read(for publicKey: PublicKey) throws -> PrivateKey? { return .none }
    func deleteKey(for publicKey: PublicKey) throws {}
}
