//
//  WalletPresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/17/23.
//

import Foundation

public final class WalletPresenter {
    public static var title: String {
        return NSLocalizedString("WALLET_TITLE",
                                 tableName: "Wallets",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Title for the wallet view")
    }
    
    public static var currencyName: String {
        NSLocalizedString("CURRENCY_NAME",
                                 tableName: "CurrencyName",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Title for the currency name")
    }
    
}
