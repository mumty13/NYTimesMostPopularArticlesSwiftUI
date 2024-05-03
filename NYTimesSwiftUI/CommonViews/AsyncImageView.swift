//
//  AsyncImageView.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color.gray)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}
