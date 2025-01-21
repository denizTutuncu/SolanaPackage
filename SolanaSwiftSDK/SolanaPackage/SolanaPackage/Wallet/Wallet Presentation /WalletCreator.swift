//
//  WalletCreator.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/25/23.
//

import Foundation

public protocol WalletCreator {
    typealias PublicKey = String
    typealias PrivateKey = String

    func create() async throws -> (PublicKey,PrivateKey)?
}
