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
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Title for the wallet view")
    }
    
    public static var currency: String {
        NSLocalizedString("CURRENCY_NAME",
                                 tableName: "CurrencyName",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Name for the currency")
    }
    
    public static var network: String {
        NSLocalizedString("NETWORK_NAME",
                                 tableName: "NetworkName",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Name for the network")
    }
    
}
