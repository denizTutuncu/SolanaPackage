//
//  SeedProviderProtocol.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public protocol SeedLoader {
    func load(completion: @escaping ([String]) -> Void)
}

