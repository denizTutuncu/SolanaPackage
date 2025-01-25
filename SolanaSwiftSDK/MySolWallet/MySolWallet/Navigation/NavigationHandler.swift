//
//  NavigationHandler.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 1/23/25.
//

import Foundation
import SolanaPackageUI

protocol OnboardingNavigation {
    func navigateToOnboarding(with seeds: [PresentableSeed])
    func navigateToExportSeed(seeds: [PresentableSeed])
    func navigateToImportSeed(seeds: [PresentableSeed])
}

protocol WalletNavigation {
    func navigateToWalletList(publicKeys: [PresentablePublicKey])
    func navigateToWalletDetail(publicKey: PresentablePublicKey, transactions: [PresentableTransaction], balance: PresentableBalance)
}
