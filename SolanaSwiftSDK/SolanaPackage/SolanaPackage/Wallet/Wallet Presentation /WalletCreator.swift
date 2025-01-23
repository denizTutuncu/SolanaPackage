//
//  WalletCreator.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation

public protocol WalletCreator {
    typealias Seed = [String]
    typealias PublicKey = String
    typealias PrivateKey = String

    func create(from seed: Seed) async throws -> (PublicKey,PrivateKey)?
}
