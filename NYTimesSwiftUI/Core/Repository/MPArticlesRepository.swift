//
//  MPArticlesRepository.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

protocol MPArticlesRepository {
    func getMostPopularArticles() async throws -> MPArticlesResponse
}

class MPArticlesRepositoryImpl: MPArticlesRepository {
    let httpClient: HTTPClient
    let baseURL: String

    init(httpClient: HTTPClient = URLSessionHTTPClient(), baseURL: String = APIConstants.articlesBaseUrl) {
        self.httpClient = httpClient
        self.baseURL = baseURL
    }

    func getMostPopularArticles() async throws -> MPArticlesResponse {
        guard let url = MPArticlesEndpoint.getMostPopularArticles.url(baseUrl: baseURL, endpoint: .mostPopularViewed) else {
            throw APIError.notFound
        }

        let request = URLRequest(url: url)

        let response = try await httpClient.get(request)
        return try DefaultResponseMapper.map(response.0, from: response.1)
    }
}
