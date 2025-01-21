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
    
    public static func map(_ domainBalance: Balance?) throws -> PresentableBalance {
        guard let domainBalance = domainBalance else {
            throw BalanceStoreError.invalidBalance
        }
        return PresentableBalance(value: String(domainBalance.amount))
    }
}

