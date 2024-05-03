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
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isSearching {
                    SearchBar(searchText: $viewModel.searchText)
                }
                if viewModel.isLoading {
                    ProgressView(StringConstants.loadingProgressText).background(.white)
                } else {
                    List(viewModel.articles, id: \.id) { article in
                        NavigationLink(destination: MPArticleDetailView(article: article)) {
                            MPArticleCellView(imageURL: article.media?.first?.mediaMetadata?.first?.url ?? "", title: article.title ?? "", byLine: article.byline ?? "", date: article.publishedDate ?? "")
                        }
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .center)
                    .listRowInsets(.init())
                    .listStyle(PlainListStyle())
                }
            }
            .toolbar(.visible, for: .automatic)
            .toolbarBackground(CustomColors.nyTimesGreen)
            .scrollContentBackground(.hidden)
            .background(CustomColors.nyTimesGreen)
            .navigationTitle(StringConstants.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isSearching.toggle()
                    }) {
                        Image(systemName: ImageConstants.magnifyingglass)
                            .foregroundColor(.black)
                    }
            )
            .onAppear {
                if viewModel.articles.isEmpty {
                    viewModel.fetchMostPopularArticles()
                }
            }
            .refreshable {
                isSearching = false
                viewModel.resetStates()
                viewModel.fetchMostPopularArticles()
            }
            .onChange(of: viewModel.searchText) { _ in
                viewModel.filterArticles()
            }
            .alert(StringConstants.errorMessage, isPresented: $viewModel.errorShow) {
                Button(StringConstants.okButtonTitle, role: .cancel) { }
            } message: {
                Text(viewModel.error?.localizedDescription ?? StringConstants.unknownErrorMessage)
            }
        }
    }
}

#Preview {
    MPArticlesView()
}
