//
//  MPArticlesViewModel.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

extension MPArticlesView {
    class ViewModel: ObservableObject {
        @Published var articles: [Article] = []
        @Published var isLoading: Bool = true
        @Published var error: Error?

        private let articlesRepository: MPArticlesRepository

        init(articlesRepository: MPArticlesRepository = MPArticlesRepositoryImpl(baseURL: APIConstants.articlesBaseUrl)) {
            self.articlesRepository = articlesRepository
        }

        func fetchMostPopularArticles() {
            isLoading = true
            Task {
                do {
                    let articlesResponse = try await articlesRepository.getMostPopularArticles()
                    DispatchQueue.main.async {
                        self.articles = articlesResponse.results ?? []
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.error = error
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
