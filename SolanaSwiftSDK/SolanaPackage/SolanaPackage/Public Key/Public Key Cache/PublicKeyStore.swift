//
//  PublicKeyStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/4/23.
//

import Foundation

public typealias CachedPublicKey = (publicKeys: [PublicKeyStore.PublicKey], timestamp: Date)

public protocol PublicKeyStore {
    typealias PublicKey = String

    func insert(_ publicKeys: [PublicKey], timestamp: Date) throws
    func retrieve() throws -> CachedPublicKey?
    func deleteCached(_ publicKeys: [PublicKey]) throws
}
