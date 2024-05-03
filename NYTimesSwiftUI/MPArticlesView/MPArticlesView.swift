//
//  ContentView.swift
//  App
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import SwiftUI
import WebKit

struct MPArticlesView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isLoading = true
    @State private var isSearching = false
    @State private var searchText = ""
    
    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { $0.title?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if isSearching {
                    SearchBar(searchText: $searchText)
                }
                if isLoading {
                    ProgressView().background(.gray)
                } else {
                    List(filteredArticles, id: \.id) { article in
                        NavigationLink(destination: MPArticleDetailView(article: article)) {
                            MPArticleCellView(imageURL: article.media?.first?.mediaMetadata?.first?.url ?? "", title: article.title ?? "", byLine: article.byline ?? "", date: article.publishedDate ?? "")
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width,
                           alignment: .center)
                    .listRowInsets(.init())
                    .listStyle(PlainListStyle())
                }
            }
            .toolbar(.visible, for: .automatic)
            .toolbarBackground(Color(red: 121/255, green: 225/255, blue: 195/255))
            .scrollContentBackground(.hidden)
            .background(Color(red: 121/255, green: 225/255, blue: 195/255))
            .navigationTitle("NY Times Most Popular")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isSearching.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
            )
            .onAppear {
                isLoading = true
                Task {
                    viewModel.fetchMostPopularArticles()
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    MPArticlesView()
}
