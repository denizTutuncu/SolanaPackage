//
//  BalanceViewModelMapperTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/20/23.
//

import XCTest
import SolanaPackage

class BalanceViewModelMapperTests: XCTestCase {
    
    func test_map_throwsErrorWithInvaidBalance() throws {
        let result = makeModelandViewModel(amount: -10)
        XCTAssertThrowsError(
            try BalanceViewModelMapper.map(result.model)
        )
    }
    
    
    func test_map_deliversViewModeleWithValidModel() throws {
        let result = makeModelandViewModel(amount: 10)
        
        let viewModel = try BalanceViewModelMapper.map(result.model)
        
        XCTAssertEqual(viewModel, result.viewModel)
    }
    
    private func makeModelandViewModel(amount: Int) -> (model: Balance, viewModel: BalanceViewModel) {
        let model = Balance(amount: amount)
        let viewModel = BalanceViewModel(amount: "\(model.amount)")
      
        return (model, viewModel)
    }
}
