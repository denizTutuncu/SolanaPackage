//
//  SeedViewModelMapper.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

public class SeedStoreMapper {
    
    private enum SeedStoreError: Swift.Error {
        case invalidSeed
    }
    
    public static func map(_ domainSeed: [DomainSeed]) throws -> [SeedUI] {
        guard !domainSeed.isEmpty else { throw SeedStoreError.invalidSeed }
        return domainSeed.map { SeedUI(value: $0.id)}
    }
}
