//
//  SeedCachePolicy.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation

final public class SeedCachePolicy {
    private init() {}
    
    public static func validateBank(seedBank: [String]) -> Bool {
        guard (seedBank.count >= 2048) else {
            return false
        }
        return true
    }
    
    public static func getRandomSeedPhrase(from bank: [String]) -> [String] {
        guard !bank.isEmpty else { return [] }
        
        var mutableBank = bank
        var randomItems = [String]()
        let numberOfItemsToGet = min(24, mutableBank.count)
        
        while randomItems.count < numberOfItemsToGet {
            let randomIndex = Int.random(in: 0..<mutableBank.count)
            let randomItem = mutableBank[randomIndex]
            
            randomItems.append(randomItem)
            mutableBank.remove(at: randomIndex)
        }
        
        return randomItems
    }

    public static func validateSeedPhrase(seed: [String]) -> Bool {
        guard (seed.count == 24) else { return false }
        return true
    }
    
    public static func hasUniqueItems(_ array: [String]) -> Bool {
        guard !array.isEmpty else { return false }
        let set = Set(array)
        return set.count == array.count
    }
    
    public static func singleSeedCount(in bank: [String]) -> Bool {
        guard !bank.isEmpty else { return false }
        for seed in bank {
            if seed.count < 3 {
                return false
            }
        }
        return true
    }
}
