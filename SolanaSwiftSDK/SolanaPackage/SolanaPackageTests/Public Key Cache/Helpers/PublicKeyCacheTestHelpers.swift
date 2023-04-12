//
//  PublicKeyCacheTestHelpers.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation

func uniquePublicKeys() -> [String] {
    return ["first unique public key","second unique public key","third unique public key"]
}

extension Date {
    func minusPublicKeyCacheMaxAge() -> Date {
        return adding(days: -publicKeyCacheMaxAgeInDays)
    }
    
    private var publicKeyCacheMaxAgeInDays: Int {
        return 3650
    }
}
