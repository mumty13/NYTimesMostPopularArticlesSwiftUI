//
//  NetworkManager.swift
//  NYTimesSwiftUI
//
//  Created by Mumtaz Hussain on 02/05/2024.
//

import Foundation

enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL) async throws -> T {
        do {
            let data = try await aPIHandler.fetchData(url: url)
            let model = try await responseHandler.fetchModel(type: type, data: data)
            return model
        } catch {
            throw error
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data
}

class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T {
        do {
            let model = try JSONDecoder().decode(type.self, from: data)
            return model
        } catch {
            throw DemoError.DecodingError
        }
    }
}
