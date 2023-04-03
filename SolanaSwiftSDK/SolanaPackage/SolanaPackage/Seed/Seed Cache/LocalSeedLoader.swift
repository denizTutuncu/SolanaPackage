//
//  LocalSeedLoader.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation

public final class LocalSeedLoader {
    public init(store: SeedBankStore) {
        self.store = store
    }
    
    public typealias Seed = [DomainSeed]
    
    private let store: SeedBankStore
}

extension LocalSeedLoader: SeedPhraseLoader {
    public func load() throws -> Seed {
        let bank = try store.loadBank()
        
        if SeedCachePolicy.validateBank(seedBank: bank) {
            let seedPhrase = SeedCachePolicy.getRandomSeedPhrase(from: bank)
            
            if SeedCachePolicy.validateSeedPhrase(seed: seedPhrase) && SeedCachePolicy.hasUniqueItems(seedPhrase) && SeedCachePolicy.singleSeedCount(in: seedPhrase) {
                return seedPhrase.toModels()
            }
        }
        return []
    }
    
}

private extension Array where Element == String {
    func toModels() -> [DomainSeed] {
        return map { DomainSeed(id: $0) }
    }
}
