//
//  PublisherViewModelTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/3/23.
//

import XCTest
import Combine
import SolanaPackage

final class PublisherViewModelTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    func test_SUTNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_SUTLoadingTrueWhenSUTInitialized() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.isLoading)
        XCTAssertNil(sut.resourceViewModel)
    }
    
    func test_SUTLoadingFalseWhenSUTReceivesData() {
        let sut = makeSUT()
        let publisher = Just("Test Resource")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Resource loads successfully")
        
        var receivedLoadingStates = [Bool]()
        
        sut.$isLoading
            .sink { isLoading in
                receivedLoadingStates.append(isLoading)
                if !isLoading {
                    XCTAssertEqual(sut.resourceViewModel, 13)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.bind(to: publisher)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(receivedLoadingStates.contains(true))
        XCTAssertTrue(receivedLoadingStates.contains(false))
    }
    
    private func makeSUT() -> ViewModelPublisher<String, Int> {
        let mapper: (String) throws -> Int = { $0.count }
        return ViewModelPublisher(mapper: mapper)
    }
}
