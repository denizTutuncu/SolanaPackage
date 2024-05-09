//
//  BalanceStoreMapper.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/12/24.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

public class BalanceStoreMapper {
    
    private enum BalanceStoreError: Swift.Error {
        case invalidBalance
    }
    
    public static func map(_ domainBalance: [Double]) throws -> [Balance] {
        guard !domainBalance.isEmpty else { throw BalanceStoreError.invalidBalance }
        return domainBalance.map { Balance(amount: $0) }
    }
}

