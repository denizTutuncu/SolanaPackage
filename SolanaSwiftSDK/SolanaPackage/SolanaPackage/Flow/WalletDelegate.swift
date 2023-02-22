//
//  FlowDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol WalletDelegate {
    func navigateToWalletCreation(from seeds: [String], completion: @escaping (String) -> Void)
    func navigateTo(wallet: Wallet, completion: @escaping ([String]) -> Void)
}

//public protocol WalletCreationProtocol {
//    associatedtype Seed
//    associatedtype PWallet: WalletProtocol
//
//    func createWallet(from seeds: [Seed], completion: @escaping (PWallet.PublicKey) -> Void)
//}
//
//public protocol PublicKeyProtocol {
//    associatedtype PWallet: WalletProtocol
//
//    func publicKey(for wallet: PWallet, completion: @escaping (PWallet.PublicKey) -> Void)
//}

//public protocol PrivateKeyProtocol {
//    associatedtype Wallet: WalletProtocol
//
//    func privateKey(for wallet: Wallet, completion: @escaping (Wallet.PrivateKey) -> Void)
//}
