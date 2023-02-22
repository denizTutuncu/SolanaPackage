//
//  WalletViewModelMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import XCTest
import SolanaPackage

class WalletViewModelMapperTests: XCTestCase {
    
    func test_map_throwsErrorWithInvaidBalance() throws {
        let result = makeModelandViewModel(balance: -1)
        XCTAssertThrowsError(
            try WalletViewModelMapper.map(result.model)
        )
    }
    
    
    func test_map_deliversViewModeleWithValidModel() throws {
        let result = makeModelandViewModel(balance: 1)
        
        let viewModel = try WalletViewModelMapper.map(result.model)
        
        XCTAssertEqual(viewModel, result.viewModel)
    }
    
    //MARK: - Helpers
    
    private func makeModelandViewModel(balance: Double) -> (model: Wallet, viewModel: WalletViewModel) {
        let id = UUID()
        let publicKey = "Unique Public Key"
        let model = Wallet(id: id, publicKey: publicKey, balance: balance)
        let viewModel = WalletViewModel(publicKey: publicKey, balance: balance)
      
        return (model, viewModel)
    }
    
}

