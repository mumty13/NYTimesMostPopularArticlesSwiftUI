//
//  MockArticlesRepository.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
@testable import NYTimesSwiftUI

class MockArticlesRepository: MPArticlesRepository {
    let shouldSucceed: Bool
    let mockArticlesResponse = mockMPArticlesResponse

    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }

    func getMostPopularArticles() async throws -> MPArticlesResponse {
        if shouldSucceed {
            return mockArticlesResponse
        }
        else {
            throw NSError(domain: "MockArticlesRepository", code: 500, userInfo: nil)
        }
    }
}
