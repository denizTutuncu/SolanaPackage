//
//  PublicKeyStoreSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 4/5/23.
//

import Foundation
import SolanaPackage

class PublicKeyStoreSpy: PublicKeyStore {

    enum ReceivedMessage: Equatable {
        case deleteCachedPublicKey([String])
        case insert([String], Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionResult: Result<Void, Error>?
    private var insertionResult: Result<Void, Error>?
    private var retrievalResult: Result<CachedPublicKey?, Error>?
    
    func deleteCached(_ publicKeys: [String]) throws {
        receivedMessages.append(.deleteCachedPublicKey(publicKeys))
        try deletionResult?.get()
    }
    
    func completeDeletion(with error: Error) {
        deletionResult = .failure(error)
    }
    
    func completeDeletionSuccessfully() {
        deletionResult = .success(())
    }
    
    func insert(_ publicKeys: [String], timestamp: Date) throws {
        receivedMessages.append(.insert(publicKeys, timestamp))
        try insertionResult?.get()
    }
    
    func completeInsertion(with error: Error) {
        insertionResult = .failure(error)
    }
    
    func completeInsertionSuccessfully() {
        insertionResult = .success(())
    }
    
    func retrieve() throws -> CachedPublicKey? {
        receivedMessages.append(.retrieve)
        return try retrievalResult?.get()
    }
    
    func completeRetrieval(with error: Error) {
        retrievalResult = .failure(error)
    }
    
    func completeRetrievalWithEmptyCache() {
        retrievalResult = .success(.none)
    }
    
    func completeRetrieval(with publicKeys: [String], timestamp: Date) {
        retrievalResult = .success(CachedPublicKey(publicKeys: publicKeys, timestamp: timestamp))
    }
}

