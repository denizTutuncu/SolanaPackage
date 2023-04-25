//
//  SeedPhraseLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/16/23.
//

import Foundation

public protocol SeedPhraseLoader {
    func load() throws -> [String]
}
