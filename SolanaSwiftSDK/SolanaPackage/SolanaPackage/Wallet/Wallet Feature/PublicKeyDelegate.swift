//
//  PublicKeyDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol PublicKeyDelegate {
    associatedtype Wallet
    func didComplete(completion: @escaping ([Wallet]) -> Void)
}
