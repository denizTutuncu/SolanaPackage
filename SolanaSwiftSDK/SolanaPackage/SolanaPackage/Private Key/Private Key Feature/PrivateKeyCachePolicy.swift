//
//  WalletCachePolicy.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation

public final class PrivateKeyCachePolicy {
    private init() {}
    static private let privateKeyByte = 32
    static private let publicKeyCount = (43...44)
    
    public static func validate(privateKey: Data) -> Bool {
        privateKey.count == privateKeyByte ? true : false
    }
    
    public static func validate(publicKey: String) -> Bool {
        !publicKeyCount.contains(publicKey.count) ? true : false
    }
}
