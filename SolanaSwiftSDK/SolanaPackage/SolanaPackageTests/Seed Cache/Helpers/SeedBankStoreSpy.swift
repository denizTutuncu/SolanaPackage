//
//  SeedStoreSpy.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/14/23.
//

import Foundation
import SolanaPackage

class SeedBankStoreSpy: SeedBankStore {
 
    enum ReceivedMessage: Equatable {
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var retrieveResult: Result<[String], Error>?
    
    func loadBank() throws -> [String] {
        receivedMessages.append(.retrieve)
        return try retrieveResult?.get() ?? []
    }
    
    func completeRetrieval(with error: Error) {
        retrieveResult = .failure(error)
    }
    
    func completeRetrievalSuccessfullyWithEmptySeed() {
        retrieveResult = .success([])
    }
    
    func completeRetrievalSuccessfully(with seed: [String]) {
        retrieveResult = .success(seed)
    }

}
