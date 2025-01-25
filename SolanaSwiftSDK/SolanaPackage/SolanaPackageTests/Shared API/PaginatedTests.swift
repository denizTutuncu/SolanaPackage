//
//  PaginatedTests.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 1/23/25.
//

import XCTest
import SolanaPackage

class PaginatedTests: XCTestCase {

    func test_init_withItemsOnly_setsItemsAndNilLoadMore() {
        let items = ["item1", "item2", "item3"]
        let sut = Paginated(items: items)

        XCTAssertEqual(sut.items, items)
        XCTAssertNil(sut.loadMore)
    }

    func test_init_withItemsAndLoadMore_setsItemsAndLoadMore() {
        let items = ["item1", "item2"]
        let loadMoreExpectation = expectation(description: "LoadMore closure executed")

        let sut = Paginated(items: items, loadMore: { completion in
            loadMoreExpectation.fulfill()
        })

        XCTAssertEqual(sut.items, items)
        XCTAssertNotNil(sut.loadMore)

        sut.loadMore? { _ in }

        wait(for: [loadMoreExpectation], timeout: 1.0)
    }

    func test_loadMore_executesClosure() {
        let loadMoreExpectation = expectation(description: "LoadMore closure executed")
        let sut = Paginated(items: [], loadMore: { completion in
            loadMoreExpectation.fulfill()
        })

        sut.loadMore? { _ in }

        wait(for: [loadMoreExpectation], timeout: 1.0)
    }

    func test_loadMoreCompletion_withSuccess_returnsPaginated() {
        let items = ["item1", "item2"]
        let newItems = ["item3", "item4"]
        let sut = Paginated(items: items, loadMore: { completion in
            let paginated = Paginated(items: newItems)
            completion(.success(paginated))
        })

        let loadMoreExpectation = expectation(description: "LoadMore completion executed")
        sut.loadMore? { result in
            switch result {
            case let .success(paginated):
                XCTAssertEqual(paginated.items, newItems)
            case .failure:
                XCTFail("Expected success, got failure instead")
            }
            loadMoreExpectation.fulfill()
        }

        wait(for: [loadMoreExpectation], timeout: 1.0)
    }

    func test_loadMoreCompletion_withFailure_returnsError() {
        let expectedError = NSError(domain: "Test", code: 1)
        let sut = Paginated(items: [], loadMore: { completion in
            completion(.failure(expectedError))
        })

        let loadMoreExpectation = expectation(description: "LoadMore completion executed")
        sut.loadMore? { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case let .failure(error as NSError):
                XCTAssertEqual(error, expectedError)
            }
            loadMoreExpectation.fulfill()
        }

        wait(for: [loadMoreExpectation], timeout: 1.0)
    }
}
