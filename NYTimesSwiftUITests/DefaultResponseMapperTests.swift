//
//  DefaultResponseMapperTests.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import XCTest
@testable import NYTimesSwiftUI

class DefaultResponseMapperTests: XCTestCase {
    func test_Mapper_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let samples = [199, 201, 300, 400, 500]
        for code in samples {
            XCTAssertThrowsError(
                try DefaultResponseMapper<AnyDecodable>
                    .map(anyData(), from: anyHTTPURLResponse(code: code))
            )
        }
    }

    func test_Mapper_deliversResponseOn200HTTPResponse() {
        let decodedResponse =
            try? DefaultResponseMapper<AnyDecodable>
                .map(anyData(), from: anyHTTPURLResponse(code: 200))
        XCTAssertNotNil(decodedResponse)
    }

    func test_Mapper_deliversErrorOnInvalidData() {
        let samples = [199, 201, 300, 400, 500, 200]
        let data = "anyData()".data(using: .utf8)!
        for code in samples {
            XCTAssertThrowsError(
                try DefaultResponseMapper<AnyDecodable>
                    .map(data, from: anyHTTPURLResponse(code: code))
            )
        }
    }
}
