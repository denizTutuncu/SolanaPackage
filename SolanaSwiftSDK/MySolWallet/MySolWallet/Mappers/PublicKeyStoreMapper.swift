//
//  WalletStoreMappler.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation
import SolanaPackage
import SolanaPackageUI

public class PublicKeyStoreMapper {
    public static func map(_ publicKeys: [String]) -> [String] {
        guard !publicKeys.isEmpty else { return [] }
        return publicKeys.map { $0 }
    }
}
