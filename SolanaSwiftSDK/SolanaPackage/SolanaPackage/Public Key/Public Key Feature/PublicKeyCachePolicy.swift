//
//  PublicKeyCachePolicy.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 4/19/23.
//

import Foundation

public final class PublicKeyCachePolicy {
    private init() {}
    static private let publicKeyCount = 44
    
    public static func isEmpty(_ publicKeys: [String]) -> Bool {
        publicKeys.count == 0 ? true : false
    }
    
    public static func getInvalidPublicKeys(from keys: [String]) -> [String] {
        return keys.filter {
            $0.count < PublicKeyCachePolicy.publicKeyCount
            ||
            $0.count > PublicKeyCachePolicy.publicKeyCount }
        
    }
    
    public static func getValidPublicKeys(from keys: [String]) -> [String] {
        return keys.filter { $0.count == PublicKeyCachePolicy.publicKeyCount }
    }
}
