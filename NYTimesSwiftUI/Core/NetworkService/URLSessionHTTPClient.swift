//
//  URLSessionHTTPClient.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

protocol HTTPClient {
    func get(_ request: URLRequest) async throws -> (Data, URLResponse)
}

final class URLSessionHTTPClient: HTTPClient {
    func get(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    let session: URLSession
}
