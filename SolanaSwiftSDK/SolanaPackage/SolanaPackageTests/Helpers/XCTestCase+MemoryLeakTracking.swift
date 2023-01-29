//
//  XCTestCase+MemoryLeakTracking.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 3/19/22.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
