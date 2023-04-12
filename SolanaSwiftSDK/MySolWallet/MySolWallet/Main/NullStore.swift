//
//  NullStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation
import SolanaPackage

class NullStore {}

extension NullStore: PrivateKeyStore {
    func insert(publicKey: PublicKey, privateKey: PrivateKey) throws {}
    func privateKey(for publicKey: PublicKey) throws -> PrivateKey {""}
    func deletePrivateKey(for publicKey: PublicKey) throws {}
}

