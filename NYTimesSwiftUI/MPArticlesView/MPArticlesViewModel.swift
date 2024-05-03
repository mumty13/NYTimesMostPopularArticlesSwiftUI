//
//  MPArticlesViewModel.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

extension MPArticlesView {
    @MainActor class ViewModel: ObservableObject {
        @Published var articles: [Article] = []
        @Published var searchText: String = ""
        @Published var isLoading: Bool = true
        @Published var error: Error?
        
        private let articlesRepository: MPArticlesRepository
        private var allArticles: [Article] = []
        
        init(articlesRepository: MPArticlesRepository = MPArticlesRepositoryImpl(baseURL: APIConstants.articlesBaseUrl)) {
            self.articlesRepository = articlesRepository
        }
        
        func fetchMostPopularArticles() {
            isLoading = true
            Task {
                do {
                    let articlesResponse = try await articlesRepository.getMostPopularArticles()
                    self.allArticles = articlesResponse.results ?? []
                    self.articles = self.allArticles
                    self.isLoading = false
                } catch {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
        
        func filterArticles() {
            if searchText.isEmpty {
                articles = allArticles
            } else {
                articles = allArticles.filter { article in
                    article.title?.localizedCaseInsensitiveContains(searchText) ?? false
                }
            }
        }
    }
}
