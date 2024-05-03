//
//  SearchBar.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(8)
                .padding(.trailing, 25)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 15)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
    }
}
