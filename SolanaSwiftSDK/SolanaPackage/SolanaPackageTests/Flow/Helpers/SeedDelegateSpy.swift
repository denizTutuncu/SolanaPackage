//
//  SeedDelegateSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/6/24.
//

import Foundation
import SolanaPackage

class SeedDelegateSpy: SeedDelegate {
    var passedSeed: [String] = []

    func didCompleteWith(seed: [String]) {
        passedSeed = seed
    }
}
