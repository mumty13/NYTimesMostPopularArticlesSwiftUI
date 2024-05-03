//
//  Coordinator.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import SwiftUI

enum Page: Hashable {
    case articleDetail(article: Article)
    case main
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(page: Page) {
        self.path.append(page)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .articleDetail(let article):
                MPArticleDetailView(article: article)
            case .main:
                MPArticlesView()
        }
    }
}

