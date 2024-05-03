//
//  MockMPArticlesResponse.swift
//  NYTimesSwiftUITests
//
//  Created by Mumtaz Hussain on 03/05/2024.
//

import Foundation
@testable import NYTimesSwiftUI

let mockMPArticlesResponse = MPArticlesResponse(
    status: "",
    copyright: "",
    numResults: nil,
    results: [
        mockArticle,
        mockArticle2
    ]
)
