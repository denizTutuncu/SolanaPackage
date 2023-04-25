//
//  PublicKeyCacheTestHelpers.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation

extension Date {
    func minusPublicKeyCacheMaxAge() -> Date {
        return adding(days: -publicKeyCacheMaxAgeInDays)
    }
    
    private var publicKeyCacheMaxAgeInDays: Int {
        return 9125 // 25 years
    }
}
