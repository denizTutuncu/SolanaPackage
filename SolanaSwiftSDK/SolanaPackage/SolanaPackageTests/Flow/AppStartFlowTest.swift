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
        makeSUT(publickeys: [], seed: []).start()
        
        XCTAssertTrue(pkDelegate.passedPublicKeys.isEmpty)
        XCTAssertTrue(sDelegate.passedSeed.isEmpty)
    }
    
    func test_start_withSeed_AndNoWallets_delegatesCorrectSeedHandling() {
        let localSeedPhrase = seedPhrase()
        makeSUT(publickeys: [], seed: localSeedPhrase).start()
        
        XCTAssertEqual(sDelegate.passedSeed, localSeedPhrase)
        
        XCTAssertEqual(sDelegate.passedSeed.count, 24, "Delegated seed phrase count must be 24.")
    }
    
    func test_start_withAtLeastOneWalletAndNoSeed_delegatesCorrectWalletHandling() {
        makeSUT(publickeys: ["First Wallet"], seed: []).start()
        
        XCTAssertEqual(pkDelegate.passedPublicKeys, ["First Wallet"])
        XCTAssertTrue(sDelegate.passedSeed.isEmpty)
    }
    
    func test_start_withTwoWallets_WITHNoSeed_delegatesWalletHandling() {
        makeSUT(publickeys: ["First Wallet", "Second Wallet"], seed: []).start()
        
        XCTAssertEqual(pkDelegate.passedPublicKeys, ["First Wallet", "Second Wallet"])
        XCTAssertTrue(sDelegate.passedSeed.isEmpty)
    }
    
    func test_startTwice_withTwoWallets_delegatesFirstWalletHandlingTwice() {
        let sut = makeSUT(publickeys: ["First Wallet", "Second Wallet"], seed:  seedPhrase())
        
        sut.start()
        XCTAssertEqual(pkDelegate.passedPublicKeys, ["First Wallet", "Second Wallet"])
        XCTAssertEqual(sDelegate.passedSeed, [])


        sut.start()
        XCTAssertEqual(pkDelegate.passedPublicKeys, ["First Wallet", "Second Wallet"])
        XCTAssertEqual(sDelegate.passedSeed, [])
    }
    
    // MARK: Helpers
    private let pkDelegate = PublicKeyDelegateSpy()
    private let sDelegate = SeedDelegateSpy()
    private weak var weakSUT: AppStartFlow<PublicKeyDelegateSpy, SeedDelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(publickeys: [String], seed: [String]) -> AppStartFlow<PublicKeyDelegateSpy, SeedDelegateSpy> {
        let sut = AppStartFlow(publickeys: publickeys, seed: seed, pkDelegate: pkDelegate, sDelegate: sDelegate)
        weakSUT = sut
        return sut
    }
    
}
