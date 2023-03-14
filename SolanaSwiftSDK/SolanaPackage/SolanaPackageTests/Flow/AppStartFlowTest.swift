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
    
//    func test_start_withNoWalletsAndNoSeed_doesNotDelegateWalletHandling() {
//        makeSUT(wallets: [], seeds: []).start()
//
//        XCTAssertTrue(delegate.passedWallets.isEmpty)
//        XCTAssertTrue(delegate.walletCompletions.isEmpty)
//        XCTAssertTrue(delegate.completedWallets.isEmpty)
//        XCTAssertTrue(delegate.seed.isEmpty)
//
//    }
//
//    func test_start_withAtLeastOneWalletAndNoSeed_delegatesCorrectWalletHandling() {
//        makeSUT(wallets: ["First Wallet"], seeds: []).start()
//
//        XCTAssertEqual(delegate.passedWallets, ["First Wallet"])
//
//        XCTAssertEqual(delegate.passedWallets.count, 1)
//        XCTAssertEqual(delegate.walletCompletions.count, 1)
//    }
//
//    func test_start_withOneWallet_delegatesAnotherCorrectWalletHandling() {
//        makeSUT(wallets: ["First Wallet", "Second Wallet"], seeds: []).start()
//
//        XCTAssertEqual(delegate.passedWallets, ["Second Wallet"])
//    }
//
//    func test_start_withTwoWallets_WITHNoSeed_delegatesFirstWalletHandling() {
//        makeSUT(wallets: ["First Wallet", "Second Wallet"], seeds: []).start()
//
//        XCTAssertEqual(delegate.passedWallets, ["First Wallet"])
//    }
    //
    //    func test_startTwice_withTwoWallets_delegatesFirstWalletHandlingTwice() {
    //        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet"])
    //
    //        sut.start()
    //        sut.start()
    //
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet", "First Wallet"])
    //    }
    //
    //    func test_startAndCompleteWithFirstAndSecondWallet_withThreeWallets_delegatesSecondAndThirdWalletHandling() {
    //        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet", "Third Wallet"])
    //        sut.start()
    //
    //        delegate.walletCompletions[0]("Second  Wallet")
    //        delegate.walletCompletions[1]("Third  Wallet")
    //
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet", "Second Wallet", "Third Wallet"])
    //    }
    //
    //    func test_startAndCompleteToSecondWallet_withOneWallet_doesNotDelegateAnotherWalletHandling() {
    //        let sut = makeSUT(wallets: ["First Wallet"])
    //        sut.start()
    //
    //        delegate.walletCompletions[0]("Second Wallet")
    //
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet"])
    //    }
    //
    //    func test_start_withEmptyWallets_doesNotCompleteBank() {
    //        makeSUT(wallets: []).start()
    //
    //        XCTAssertTrue(delegate.passedWallets.isEmpty)
    //    }
    //
    //    func test_startAndCompleteFirstWallet_withTwoWallets_doesStartTheBank() {
    //        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet"])
    //        sut.start()
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 1)
    //
    //        delegate.walletCompletions[0]("Second Wallet")
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 2)
    //
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet", "Second Wallet"])
    //    }
    //
    //    func test_startAndCompletesToThirdWallet_withTwoWallets_doesNotDelegateAnotherWalletHandling() {
    //        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet"])
    //        sut.start()
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 1)
    //
    //        delegate.walletCompletions[0]("Second Wallet")
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 2)
    //
    //        delegate.walletCompletions[1]("Third Wallet")
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 2)
    //
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet", "Second Wallet"])
    //    }
    //
    //    func test_startAndCompletesToThirdWallet_doesStartTheBank() {
    //        let sut = makeSUT(wallets: ["First Wallet", "Second Wallet", "Third Wallet"])
    //        sut.start()
    //
    //        XCTAssertEqual(delegate.passedWallets.count, 1)
    //
    //        delegate.walletCompletions[0]("Second Wallet")
    //
    //        assertEqual(delegate.completedWallets[0], [("First Wallet", "First Wallet")])
    //        XCTAssertEqual(delegate.passedWallets.count, 2)
    //
    //        delegate.walletCompletions[1]("Third Wallet")
    //
    //        assertEqual(delegate.completedWallets[1], [("Second Wallet", "Second Wallet")])
    //        XCTAssertEqual(delegate.passedWallets.count, 3)
    //
    //        assertEqual(delegate.completedWallets[2], [("Third Wallet", "Third Wallet")])
    //        XCTAssertEqual(delegate.passedWallets, ["First Wallet", "Second Wallet", "Third Wallet"])
    //    }
    
    // MARK: Helpers
    
    private let delegate = WalletDelegateSpy()
    
    private weak var weakSUT: AppStartFlow<WalletDelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(wallets: [String], seeds: [String]) -> AppStartFlow<WalletDelegateSpy> {
        let sut = AppStartFlow(wallets: wallets, seeds: seeds, delegate: delegate)
        weakSUT = sut
        return sut
    }
    
}
