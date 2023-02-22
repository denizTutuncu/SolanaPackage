//
//  WalletViewModel.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation

public struct WalletViewModel {
    public let publicKey: String
    public let balance: String
    public init(publicKey: String, balance: Double) {
        self.publicKey = publicKey
        self.balance = String(balance)
    }
}

extension WalletViewModel: Equatable {
    public static func == (lhs: WalletViewModel, rhs: WalletViewModel) -> Bool {
        lhs.publicKey == rhs.publicKey
    }
}
