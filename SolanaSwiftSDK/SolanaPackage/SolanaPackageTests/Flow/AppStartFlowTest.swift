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
        makeSUT(wallets: [], seed: []).start()
        
        XCTAssertTrue(walletDelegate.walletCompletions.isEmpty)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
    }
    
    func test_start_withSeed_AndNoWallets_delegatesCorrectSeedHandling() {
        let localSeedPhrase = seedPhrase().local
        makeSUT(wallets: [], seed: localSeedPhrase).start()
        
        XCTAssertTrue(walletDelegate.walletCompletions.isEmpty)
        XCTAssertEqual(seedDelegate.seed, localSeedPhrase)
        
        XCTAssertEqual(seedDelegate.seed.count, 24, "Delegated seed phrase count must be 24.")
    }
    
    func test_start_withAtLeastOneWalletAndNoSeed_delegatesCorrectWalletHandling() {
        makeSUT(wallets: ["First Wallet"], seed: []).start()
        
        XCTAssertEqual(walletDelegate.walletCompletions.count, 1)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
        
    }
    
    func test_start_withTwoWallets_WITHNoSeed_delegatesWalletHandling() {
        makeSUT(wallets: ["First Wallet", "Second Wallet"], seed: []).start()
        
        XCTAssertEqual(walletDelegate.walletCompletions.count, 1)
        XCTAssertTrue(seedDelegate.seed.isEmpty)
    }
    
    func test_startTwice_withTwoWallets_delegatesFirstWalletHandlingTwice() {
        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet"], seed: [])
        
        sut.start()
        XCTAssertEqual(walletDelegate.walletCompletions.count, 1)
        
        sut.start()
        XCTAssertEqual(walletDelegate.walletCompletions.count, 2)
    }
    
    // MARK: Helpers
    
    private let walletDelegate = WalletDelegateSpy()
    private let seedDelegate = SeedDelegateSpy()
    
    private weak var weakSUT: AppStartFlow<WalletDelegateSpy, SeedDelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(wallets: [String], seed: [String]) -> AppStartFlow<WalletDelegateSpy, SeedDelegateSpy> {
        let sut = AppStartFlow(wallets: wallets, seed: seed, walletDelegate: walletDelegate, seedDelegate: seedDelegate)
        weakSUT = sut
        return sut
    }
    
}
