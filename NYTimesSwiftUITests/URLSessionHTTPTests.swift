//
//  URLSessionHTTPTests.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
import XCTest

@testable import NYTimesSwiftUI

class URLSessionHTTPTests: XCTestCase {
    override func setUp() {
        URLProtocolStub.startInterceptingRequests()
    }
    override func tearDown() {
        URLProtocolStub.stopInterceptingRequests()
    }
}

extension URLSessionHTTPTests {
    func test_makeGetRequest_ExpectToReceiveAnErrorWhenStubbingAnError() async {
        let sut = makeSUT()
        stub(data: anyData(), response: anyHTTPURLResponse(), error: anyNSError())
        await expect(expectedResult: .failure(anyNSError()), sut: sut, request: anyRequest())
    }

    func test_makeGetRequest_ExpectToReceiveAResponserWhenStubbingAResponse() async {
        let sut = makeSUT()
        stub(data: anyData(), response: anyHTTPURLResponse(), error: nil)
        await expect(expectedResult: .success(anyData()), sut: sut, request: anyRequest())
    }
}

extension URLSessionHTTPTests {
    func makeSUT() -> URLSessionHTTPClient {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let client = URLSessionHTTPClient(session: session)
        trackForMemoryLeaks(client)
        return client
    }

    func expect(
        expectedResult: Result<Data, NSError>,
        sut: URLSessionHTTPClient,
        request: URLRequest
    ) async {
        switch expectedResult {
            case let .success(expectedData):
                do {
                    let result = try await sut.get(request)
                   XCTAssertEqual(expectedData, result.0)
                } catch {
                    XCTFail("Unexpected error: \(error)")
                }
            case let .failure(error):
                do {
                    let result = try await sut.get(request)
                    XCTFail("Expected an error, but got a result: \(result)")
                } catch let recievedError as NSError {
                    XCTAssertEqual(recievedError.domain, error.domain)
                    XCTAssertEqual(recievedError.code, error.code)
                } catch {
                    XCTFail("Unexpected error: \(error)")
                }
        }
    }

    func stub(data: Data, response: HTTPURLResponse, error: Error?) {
        URLProtocolStub.stub(data: data, response: response, error: error)
    }
}
