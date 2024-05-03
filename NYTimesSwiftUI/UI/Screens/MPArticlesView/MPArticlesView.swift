//
//  ContentView.swift
//  App
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import SwiftUI
import WebKit

struct MPArticlesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isSearching {
                    SearchBar(searchText: $viewModel.searchText)
                }
                if viewModel.isLoading {
                    ProgressView(StringConstants.loadingProgressText).background(.white)
                } else {
                    List(viewModel.articles, id: \.id) { article in
                        MPArticleCellView(
                            imageURL: article.media?.first?.mediaMetadata?.first?.url ?? "",
                            title: article.title ?? "",
                            byLine: article.byline ?? "",
                            date: article.publishedDate ?? ""
                        )
                        .onTapGesture {
                            coordinator.push(page: .articleDetail(article: article))
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
                        viewModel.isSearching.toggle()
                    }) {
                        Image(systemName: ImageConstants.magnifyingglass)
                            .foregroundColor(.black)
                    }
            )
            .task {
                if viewModel.articles.isEmpty {
                    await viewModel.fetchMostPopularArticles()
                }
            }
            .refreshable {
                viewModel.resetStates()
                Task {
                    await viewModel.fetchMostPopularArticles()
                }
            }
            .onChange(of: viewModel.searchText) { _ in
                viewModel.filterArticles()
            }
            .alert(StringConstants.errorMessage, isPresented: $viewModel.errorShow) {
                Button(StringConstants.okButtonTitle, role: .cancel) {}
            } message: {
                Text(viewModel.error?.localizedDescription ?? StringConstants.unknownErrorMessage)
            }
        }
    }
}

#Preview {
    MPArticlesView()
}
