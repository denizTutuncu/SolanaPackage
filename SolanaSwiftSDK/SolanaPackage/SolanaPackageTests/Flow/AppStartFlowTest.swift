//
//  AppStartFlowTest.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/23/23.
//

import Foundation
import XCTest
@testable import SolanaPackage

class AppStartFlowTest: XCTestCase {
    
    func test_start_withNoWalletsAndNoSeed_doesNotDelegateWalletOrSeedHandling() {
        makeSUT(publicKeys: [], seed: []).start()
        
        XCTAssertTrue(publicKeyDelegate.publicKeyCompletions.isEmpty)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
    }
    
    func test_start_withSeed_AndNoWallets_delegatesCorrectSeedHandling() {
        let localSeedPhrase = seedPhrase().local
        makeSUT(publicKeys: [], seed: localSeedPhrase).start()
        
        XCTAssertTrue(publicKeyDelegate.publicKeyCompletions.isEmpty)
        XCTAssertEqual(seedDelegate.seed, localSeedPhrase)
        
        XCTAssertEqual(seedDelegate.seed.count, 24, "Delegated seed phrase count must be 24.")
    }
    
    func test_start_withAtLeastOneWalletAndNoSeed_delegatesCorrectWalletHandling() {
        makeSUT(publicKeys: ["First Wallet"], seed: []).start()
        
        XCTAssertEqual(publicKeyDelegate.publicKeyCompletions.count, 1)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
        
    }
    
    func test_start_withTwoWallets_WITHNoSeed_delegatesWalletHandling() {
        makeSUT(publicKeys: ["First Wallet", "Second Wallet"], seed: []).start()
        
        XCTAssertEqual(publicKeyDelegate.publicKeyCompletions.count, 1)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
    }
    
    func test_startTwice_withTwoWallets_delegatesFirstWalletHandlingTwice() {
        let sut = makeSUT(publicKeys: ["First Wallet", "Second Wallet"], seed:  seedPhrase().local)
        
        sut.start()
        XCTAssertEqual(publicKeyDelegate.publicKeyCompletions.count, 1)
        
        sut.start()
        XCTAssertEqual(publicKeyDelegate.publicKeyCompletions.count, 2)
    }
    
    // MARK: Helpers
    
    private let publicKeyDelegate = PublicKeyDelegateSpy()
    private let seedDelegate = SeedDelegateSpy()
    
    private weak var weakSUT: AppStartFlow<PublicKeyDelegateSpy, SeedDelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(publicKeys: [String], seed: [String]) -> AppStartFlow<PublicKeyDelegateSpy, SeedDelegateSpy> {
        let sut = AppStartFlow(publicKeys: publicKeys, seed: seed, publicKeyDelegate: publicKeyDelegate, seedDelegate: seedDelegate)
        weakSUT = sut
        return sut
    }
    
}
