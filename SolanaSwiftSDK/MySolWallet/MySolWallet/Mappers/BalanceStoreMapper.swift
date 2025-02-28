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
    public static func map(_ domainBalance: Balance?) -> PresentableBalance? {
        guard let domainBalance = domainBalance else {
            return nil
        }
        return PresentableBalance(value: String(domainBalance.amount))
    }
}

