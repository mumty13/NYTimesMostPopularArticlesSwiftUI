//
//  XCTestCase+MemoryLeakTracking.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
