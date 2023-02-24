//
//  SeedProviderProtocol.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation

public protocol SeedProviderProtocol {
    func load(completion: @escaping ([String]) -> Void)
}
