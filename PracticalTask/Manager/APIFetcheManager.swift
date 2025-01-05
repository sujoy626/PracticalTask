//
//  APIFetcherManager.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIFetcherProtocol {
    func fetching(url: String,method: HTTPMethods) async throws -> Data
}

class APIFetcherManager: APIFetcherProtocol {
    
    private let session: URLSession
//    private let url: URL
    
    init(session: URLSession = .shared) {
//        self.url = url
        self.session = session
    }
    
    func fetching(url: String,method: HTTPMethods) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw CustomError.invalidURL
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw CustomError.unknownError
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                throw CustomError.response(code: httpResponse.statusCode, message: message)
            }
            
            return data
        } catch {
            throw CustomError.invalidURL
        }
    }
}
