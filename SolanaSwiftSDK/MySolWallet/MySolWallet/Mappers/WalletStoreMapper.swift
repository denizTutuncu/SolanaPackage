//
//  WalletStoreMappler.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

public class WalletStoreMapper {
    
    public static func map(_ domainWallets: [DomainWallet]) -> [WalletUI] {
        guard !domainWallets.isEmpty else { return [] }
        return domainWallets.map { WalletUI(id: $0.id, publicKey: $0.publicKey, balance: "0") }
    }
}
