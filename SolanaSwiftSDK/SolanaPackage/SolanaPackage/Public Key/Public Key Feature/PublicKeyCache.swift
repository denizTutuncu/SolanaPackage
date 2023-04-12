//
//  PublicKeyCache.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation

public protocol PublicKeyCache {
    func save(_ publicKeys: [String]) throws
}

