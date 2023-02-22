//
//  NullStore.swift
//  MySolWallet
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation
import SolanaPackage

class NullStore {}

extension NullStore: WalletStore {    
    func deleteCachedWallet() throws {}
    
    func insert(_ feed: [LocalWallet], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedWallet? { .none }
}

