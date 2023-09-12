//
//  PrivateKeyStoreSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/21/23.
//

import Foundation
import SolanaPackage

class PrivateKeyStoreSpy: PrivateKeyStore {
   
    enum ReceivedMessage: Equatable {
        case deleteCached(String)
        case insert(String,String)
        case privateKey(String)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionResult: Result<Void, Error>?
    private var insertionResult: Result<Void, Error>?
    private var privateKeyResult: Result<String?, Error>?

    func deleteKey(for publicKey: PublicKey) throws {
        receivedMessages.append(.deleteCached(publicKey))
        try deletionResult?.get()
    }
    
    func completeDeletion(with error: Error) {
        deletionResult = .failure(error)
    }
    
    func completeDeletionSuccessfully() {
        deletionResult = .success(())
    }
    
    func store(publicKey: PublicKey, privateKey: PrivateKey) throws {
        receivedMessages.append(.insert(publicKey,privateKey))
        try insertionResult?.get()
    }
    
    func completeInsertion(with error: Error) {
        insertionResult = .failure(error)
    }
    
    func completeInsertionSuccessfully() {
        insertionResult = .success(())
    }
    
    func read(for publicKey: PublicKey) throws -> PrivateKey? {
        receivedMessages.append(.privateKey(publicKey))
        return try privateKeyResult?.get()
    }
    
    func complete(with error: Error) {
        privateKeyResult = .failure(error)
    }
    
    func completeWithEmptyCache(with error: Error) {
        privateKeyResult = .failure(error)
    }
    
    func complete(with privateKey: String) {
        privateKeyResult = .success(privateKey)
    }

}
