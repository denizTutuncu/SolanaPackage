//
//  PublicKeyStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/4/23.
//

import Foundation

public typealias CachedPublicKey = (publicKeys: [String], timestamp: Date)

public protocol PublicKeyStore {
    func insert(_ publicKeys: [String], timestamp: Date) throws
    func retrieve() throws -> CachedPublicKey?
    func deleteCached(_ publicKeys: [String]) throws
}
