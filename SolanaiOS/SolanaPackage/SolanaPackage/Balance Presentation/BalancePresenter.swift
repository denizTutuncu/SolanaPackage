//
//  BalancePresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 1/11/23.
//

import Foundation

public final class BalancePresenter {
    public static var title: String {
        NSLocalizedString("BALANCE_VIEW_TITLE",
            tableName: "Balance",
            bundle: Bundle(for: BalancePresenter.self),
            comment: "Title for the balance view")
    }
}
