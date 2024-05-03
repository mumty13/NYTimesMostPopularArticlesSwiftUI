//
//  NetworkService.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

protocol MostPopularArticlesDelegate {
    func fetchMostPopularArticles() async throws -> MPArticlesResponse
}

class CommentViewService: MostPopularArticlesDelegate {
    
    private let networkManager = NetworkManager()
    
    func fetchMostPopularArticles() async throws -> MPArticlesResponse {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=i2Lr0vKHei52aOeKeTuvIJI69Nplxmiu") else {
            throw DemoError.BadURL
        }
        return try await networkManager.fetchRequest(type: MPArticlesResponse.self, url: url)
    }
}

