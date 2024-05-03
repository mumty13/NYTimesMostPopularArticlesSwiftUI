//
//  APIConstants.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

enum MPArticlesEndpoint {
    case getMostPopularArticles
}

enum APIConstants {
    static let articlesBaseUrl = "https://api.nytimes.com/svc"
    static let apiKey = "i2Lr0vKHei52aOeKeTuvIJI69Nplxmiu"
}

enum APIEndpoint {
    case mostPopularViewed
    
    func path() -> String {
        switch self {
        case .mostPopularViewed:
            return "/mostpopular/v2/viewed/1.json"
        }
    }
}

extension MPArticlesEndpoint {
    func url(baseUrl: String, endpoint: APIEndpoint) -> URL? {
        switch self {
        case .getMostPopularArticles:
            let urlString = baseUrl + endpoint.path() + "?api-key=\(APIConstants.apiKey)"
            return URL(string: urlString)
        }
    }
}
