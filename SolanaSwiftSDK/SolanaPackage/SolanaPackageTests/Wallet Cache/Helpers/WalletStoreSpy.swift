//
//  WalletStoreSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation
import SolanaPackage

class WalletStoreSpy: WalletStore {
    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert([LocalWallet], Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionResult: Result<Void, Error>?
    private var insertionResult: Result<Void, Error>?
    private var retrievalResult: Result<CachedWallet?, Error>?
    
    func deleteCachedWallet() throws {
        receivedMessages.append(.deleteCachedFeed)
        try deletionResult?.get()
    }
    
    func completeDeletion(with error: Error) {
        deletionResult = .failure(error)
    }
    
    func completeDeletionSuccessfully() {
        deletionResult = .success(())
    }
    
    func insert(_ feed: [LocalWallet], timestamp: Date) throws {
        receivedMessages.append(.insert(feed, timestamp))
        try insertionResult?.get()
    }
    
    func completeInsertion(with error: Error) {
        insertionResult = .failure(error)
    }
    
    func completeInsertionSuccessfully() {
        insertionResult = .success(())
    }
    
    func retrieve() throws -> CachedWallet? {
        receivedMessages.append(.retrieve)
        return try retrievalResult?.get()
    }
    
    func completeRetrieval(with error: Error) {
        retrievalResult = .failure(error)
    }
    
    func completeRetrievalWithEmptyCache() {
        retrievalResult = .success(.none)
    }
    
    func completeRetrieval(with wallet: [LocalWallet], timestamp: Date) {
        retrievalResult = .success(CachedWallet(wallet: wallet, timestamp: timestamp))
    }
}

