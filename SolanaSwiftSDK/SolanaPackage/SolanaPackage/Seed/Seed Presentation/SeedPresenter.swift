//
//  SeedPresenter.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/27/23.
//

import Foundation

public final class SeedPresenter {
    public static var title: String {
        return NSLocalizedString("SEED_LIST_TITLE",
                                 tableName: "Seed",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Title for the seed list view")
    }
    
    public static var subtitle: String {
        NSLocalizedString("SEED_LIST_SUBTITLE",
                                 tableName: "Seed",
                                 bundle: Bundle(for: WalletPresenter.self),
                                 comment: "Subtitle for the seed list view")
    }
    
}
