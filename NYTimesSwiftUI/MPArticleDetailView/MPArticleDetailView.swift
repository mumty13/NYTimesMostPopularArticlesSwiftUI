//
//  MPArticleDetailView.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import SwiftUI

struct MPArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImageView(imageURL: article.media?.first?.mediaMetadata?.last?.url ?? "")
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title ?? "")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    Text(article.byline ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 5) {
                        Spacer()
                        Image(systemName: ImageConstants.calendar)
                            .foregroundColor(.gray)
                        Text(article.publishedDate ?? "")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    Text(article.abstract ?? "")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    if let url = URL(string: article.url ?? "") {
                        Link(StringConstants.readMoreText, destination: url)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 40)
        }
    }
}
