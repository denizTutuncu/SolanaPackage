//
//  LocalSeedLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation

public final class LocalSeedLoader {
    public init(store: SeedStore) {
        self.store = store
    }
    
    public typealias Seed = [String]
    
    private let store: SeedStore
}

extension LocalSeedLoader: SeedPhraseLoader {
    public func load() throws -> [String] {
        let bank = try store.loadSeed()
        guard SeedCachePolicy.validateBank(seedBank: bank) else { return [] }

        let seedPhrase = SeedCachePolicy.getRandomSeedPhrase(from: bank)
        guard SeedCachePolicy.validateSeedPhrase(seed: seedPhrase) else { return [] }

        return seedPhrase
    }
}

private extension Array where Element == String {
    func toModels() -> [String] {
        return map { $0 }
    }
}
