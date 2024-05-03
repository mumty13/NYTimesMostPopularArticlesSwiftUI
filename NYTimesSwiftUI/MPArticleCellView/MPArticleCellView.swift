//
//  MPArticleCellView.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import SwiftUI

struct MPArticleCellView: View {
    let imageURL: String
    let title: String
    let byLine: String
    let date: String
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImageView(imageURL: imageURL)
                .frame(width: 40, height: 40)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(byLine)
                    .font(.subheadline)
                    .lineLimit(2)
                HStack(spacing: 5) {
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(date)
                        .font(.footnote)
                }
            }
            .padding(.trailing, 10)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
