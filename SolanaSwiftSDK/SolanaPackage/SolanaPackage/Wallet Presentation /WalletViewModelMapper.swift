//
//  WalletViewModelMapper.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation

public class WalletViewModelMapper {
    
    private enum Error: Swift.Error {
        case invalidBalance
    }
    
    public static func map(_ wallet: Wallet) throws -> WalletViewModel {
        guard wallet.balance >= 0.0 else { throw Error.invalidBalance }
        return  WalletViewModel(publicKey: wallet.publicKey, balance: wallet.balance)
    }
}
