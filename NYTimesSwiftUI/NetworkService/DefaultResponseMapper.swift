//
//  DefaultResponseMapper.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation


final class DefaultResponseMapper<T> {
    static func map(_ data: Data, from response: URLResponse) throws -> T
    where T: Decodable {
        let jsonDecoder = JSONDecoder()
        guard let response = response as? HTTPURLResponse else { throw APIError.invalidData }
        guard response.statusCode == statusCode200,
            let decodedResponse = try? jsonDecoder.decode(T.self, from: data)
        else {
            throw APIError(response: response)
        }

        return decodedResponse
    }

    private static var statusCode200: Int { return 200 }
}
