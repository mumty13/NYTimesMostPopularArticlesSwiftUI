//
//  RepositoryTests.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
import XCTest

@testable import NYTimesSwiftUI

class MPArticlesRepositoryTests: XCTestCase {
    
    func testGetMostPopularArticlesSuccess() async throws {
        let mockHTTPClient = MockHTTPClient(shouldSucceed: true)
        let repository = MPArticlesRepositoryImpl(httpClient: mockHTTPClient, baseURL: "https://example.com/api")
        
        let articlesResponse = try await repository.getMostPopularArticles()
        
        XCTAssertNotNil(articlesResponse)
    }
    
    func testGetMostPopularArticlesFailure() async throws {
        let mockHTTPClient = MockHTTPClient(shouldSucceed: false)
        let repository = MPArticlesRepositoryImpl(httpClient: mockHTTPClient, baseURL: "https://example.com/api")
        
        do {
            _ = try await repository.getMostPopularArticles()
            XCTFail("the api should throw an error")
        }
        catch {
            XCTAssertEqual((error as NSError).domain, "MockHTTPClient")
            XCTAssertEqual((error as NSError).code, 500)
        }
    }
    
    func testGetMostPopularArticlesFailure() async throws {
        let mockHTTPClient = MockHTTPClient(shouldSucceed: false)
        let repository = MPArticlesRepositoryImpl(httpClient: mockHTTPClient, baseURL: "https://example.com/api")
        
        do {
            _ = try await repository.getMostPopularArticles()
            XCTFail("the api should throw an error")
        }
        catch {
            XCTAssertEqual((error as NSError).domain, "MockHTTPClient")
            XCTAssertEqual((error as NSError).code, 500)
        }
    }
}

class MockHTTPClient: HTTPClient {
    let shouldSucceed: Bool
    
    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }
    
    func get(_ request: URLRequest) async throws -> (Data, URLResponse) {
        if shouldSucceed {
            let response =  mockMPArticlesResponse
            
            let data = try! JSONEncoder().encode(response)
            let httpResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, httpResponse)
        } else {
            throw NSError(domain: "MockHTTPClient", code: 500, userInfo: nil)
        }
    }
}
