//
//  WalletCachePolicy.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public final class PrivateKeyCachePolicy {
    private init() {}
    static private let privateKeyCount = 64
    static private let publicKeyCount = 44
    
    public static func validate(privateKey: String) -> Bool {
        privateKey.count == PrivateKeyCachePolicy.privateKeyCount ? true : false
    }
    
    public static func validate(publicKey: String) -> Bool {
        publicKey.count == PrivateKeyCachePolicy.publicKeyCount ? true : false
    }
}
