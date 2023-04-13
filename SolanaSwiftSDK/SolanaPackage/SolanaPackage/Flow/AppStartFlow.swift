//
//  MainFlow.swift
//  SolanaPackage
//
//  Created by Deniz Tutuncu on 2/18/23.
//

import Foundation

public final class AppStartFlow<PubKeyDelgt: PublicKeyDelegate, SeedDelgt: SeedDelegate>{
    public typealias PublicKey = PubKeyDelgt.PublicKey
    public typealias Seed = SeedDelgt.Seed
    
    private var publicKeys: [PublicKey]
    private let seed: [Seed]
    private let publicKeyDelegate: PubKeyDelgt
    private let seedDelegate: SeedDelgt
    
    public init(publicKeys: [PublicKey], seed: [Seed], publicKeyDelegate: PubKeyDelgt, seedDelegate: SeedDelgt) {
        self.publicKeys = publicKeys
        self.seed = seed
        self.publicKeyDelegate = publicKeyDelegate
        self.seedDelegate = seedDelegate
    }
    
    public func start() {
        delegateHandlingPublicKeys(at: publicKeys.startIndex)
    }
    
    private func delegateHandlingPublicKeys(at index: Int) {
        if index < publicKeys.endIndex {
            publicKeyDelegate.didComplete(completion: publicKeys(at: index))
        } else {
            seedDelegate.didComplete(completion: seed)
        }
    }
    
    private func delegateExistingWalletHandling(after index: Int) {
        delegateHandlingPublicKeys(at: publicKeys.index(after: index))
    }
    
    private func publicKeys(at index: Int) -> ([PublicKey]) -> Void {
        return { [weak self] publicKeys in
            for (index,publicKey) in publicKeys.enumerated() {
                self?.publicKeys.replaceOrInsert(publicKey, at: index)
            }
            self?.delegateExistingWalletHandling(after: index)
        }
    }
 
}

private extension Array {
    mutating func replaceOrInsert(_ element: Element, at index: Index) {
        if index < count {
            remove(at: index)
        }
        insert(element, at: index)
    }
}
