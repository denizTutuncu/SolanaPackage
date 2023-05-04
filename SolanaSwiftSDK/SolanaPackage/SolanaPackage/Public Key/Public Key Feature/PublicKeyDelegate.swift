//
//  PublicKeyDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public protocol PublicKeyDelegate {
    func didCompleteWith(keys: [String])
    func didCompleteWith(seed: [String])
}
