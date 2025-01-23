//
//  WalletPresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/17/23.
//

import Foundation

public final class WalletPresenter {
    
    // MARK: - WALLET VIEW
    public static var currencyName: String {
        NSLocalizedString("WALLET_VIEW_CURRENCY_NAME",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Currency name for the wallet view")
    }
    
    public static var networkName: String {
        NSLocalizedString("WALLET_VIEW_NETWORK_NAME",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Network name for the wallet view")
    }
    
    // MARK: - WALLET LIST VIEW
    public static var walletListViewTitle: String {
        return NSLocalizedString("WALLET_LIST_VIEW_TITLE",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Title for the wallet list view")
    }
    
    public static var walletListViewSubtitle: String {
        return NSLocalizedString("WALLET_LIST_VIEW_SUBTITLE",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Subtitle for tthe wallet list view")
    }
    
    public static var walletListViewErrorMessage: String {
        NSLocalizedString("WALLET_LIST_VIEW_ERROR_MESSAGE",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Error message for the wallet list view")
    }
    
    
    public static var walletListErrorButtonTitle: String {
        NSLocalizedString("WALLET_LIST_VIEW_ERROR_BUTTON_TITLE",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Error button title for the wallet list view")
    }
    
    public static var walletListViewLoadingTitle: String {
        NSLocalizedString("WALLET_LIST_VIEW_LOADING_TITLE",
                                 tableName: "Wallet",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Loading title for the wallet list view")
    }
}
