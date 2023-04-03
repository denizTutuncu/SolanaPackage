//
//  SeedStore.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation

public protocol SeedBankStore {
    func loadBank() throws -> [String]
}

