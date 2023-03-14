//
//  TransactionPresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public final class TransactionPresenter {
    public static var listTitle: String {
        return NSLocalizedString("LIST_TITLE",
                                 tableName: "Transaction",
                                 bundle: Bundle(for: TransactionPresenter.self),
                                 comment: "Title for the transaction list view title")
    }
    
    public static var listSubtitle: String {
        NSLocalizedString("LIST_SUBTITLE",
                                 tableName: "Transaction",
                                 bundle: Bundle(for: TransactionPresenter.self),
                                 comment: "Subtitle for the transaction list view title")
    }
    
}
