//
//  SeedDelegate.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/24/23.
//

import Foundation

public protocol SeedDelegate {
    associatedtype Seed
    func didComplete(completion: [Seed])
}
