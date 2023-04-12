//
//  PublicKeyStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/4/23.
//

import Foundation

public typealias CachedPublicKey = (publicKeys: [String], timestamp: Date)

public protocol PublicKeyStore {
    func deleteCached(_ publicKeys: [String]) throws
    func insert(_ publicKeys: [String], timestamp: Date) throws
    func retrieve() throws -> CachedPublicKey?
}
