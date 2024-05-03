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
        @Published var isSearching = false
        @Published var error: Error?
        @Published var errorShow: Bool = false
        
        private let articlesRepository: MPArticlesRepository
        private var allArticles: [Article] = []
        
        init(articlesRepository: MPArticlesRepository = MPArticlesRepositoryImpl(baseURL: APIConstants.articlesBaseUrl)) {
            self.articlesRepository = articlesRepository
        }
        
        func fetchMostPopularArticles() async {
            isLoading = true
            do {
                let articlesResponse = try await articlesRepository.getMostPopularArticles()
                self.allArticles = articlesResponse.results ?? []
                self.articles = self.allArticles
                self.isLoading = false
                self.errorShow = false
            }
            catch {
                self.error = error
                self.isLoading = false
                self.errorShow = true
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
        
        func resetStates() {
            isSearching = false
            errorShow = false
            searchText = ""
            error = nil
        }
    }
}
