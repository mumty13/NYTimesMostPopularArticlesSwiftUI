//
//  ViewModelTests.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
import XCTest

@testable import NYTimesSwiftUI

@MainActor
class ViewModelTests: XCTestCase {

    func testFetchMostPopularArticles_Success() async throws {
        // Given
        let mockRepository = MockArticlesRepository(shouldSucceed: true)
        let viewModel = MPArticlesView.ViewModel(articlesRepository: mockRepository)

        // When
        await viewModel.fetchMostPopularArticles()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.errorShow)
        XCTAssertNotNil(viewModel.articles)
        XCTAssertEqual(viewModel.articles, mockRepository.mockArticlesResponse.results)
    }

    func testFetchMostPopularArticles_Failure() async throws {
        // Given
        let mockRepository = MockArticlesRepository(shouldSucceed: false)
        let viewModel = MPArticlesView.ViewModel(articlesRepository: mockRepository)

        // When
        await viewModel.fetchMostPopularArticles()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.errorShow)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.articles.isEmpty)
    }

    func testFilterArticles() async {
        // Given
        let mockRepository = MockArticlesRepository(shouldSucceed: true)
        let viewModel = MPArticlesView.ViewModel(articlesRepository: mockRepository)
        
        // When
        await viewModel.fetchMostPopularArticles()

        // Then
        XCTAssertEqual(viewModel.articles.count, 2)

        // Given
        viewModel.searchText = "Article 2"
        viewModel.filterArticles()
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Article 2")
        
        // Given
        viewModel.searchText = "Article 3"
        viewModel.filterArticles()
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 0)
        
        // Given
        viewModel.searchText = ""
        viewModel.filterArticles()
        
        // Then
        XCTAssertEqual(viewModel.articles.count, 2)
        XCTAssertEqual(viewModel.articles.first?.title, "Article 1")
    }
    
    func testResetStates() {
        // Given
        let mockRepository = MockArticlesRepository(shouldSucceed: true)
        let viewModel = MPArticlesView.ViewModel(articlesRepository: mockRepository)
        viewModel.isSearching = true
        viewModel.errorShow = true
        viewModel.searchText = "Test"
        viewModel.error = NSError(domain: "test", code: 500, userInfo: nil)

        // When
        viewModel.resetStates()

        // Then
        XCTAssertFalse(viewModel.isSearching)
        XCTAssertFalse(viewModel.errorShow)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertNil(viewModel.error)
    }
}
