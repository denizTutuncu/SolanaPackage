//
//  WalletCachePolicy.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

final class KeychainWalletCachePolicy {
    private init() {}
    
    static func validate(privateKey: String?) -> Bool {
        guard let privateKey = privateKey, !privateKey.isEmpty else {
            return false
        }
        return true
    }
    
    static func validate(publicKey: String) -> Bool {
        guard !publicKey.isEmpty else {
            return false
        }
        return true
    }
}
