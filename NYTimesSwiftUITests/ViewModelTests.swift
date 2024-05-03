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
        await viewModel.fetchMostPopularArticles()

        XCTAssertEqual(viewModel.articles.count, 2)

        viewModel.searchText = "Article 2"
        viewModel.filterArticles()

        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Article 2")
    }
}
