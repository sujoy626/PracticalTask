//
//  NetworkManager.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Foundation


enum CustomError : Error {
    case invalidURL
    case decodingError(message : String)
    case noData
    case response(code : Int, message : String)
    case customError(code : Int, message : String)
    case unknownError
}

protocol NetworkManagerProtocol: AnyObject {
    func fetch<T: Codable>(method: HTTPMethods) async throws -> T
}


class NetworkManager: NetworkManagerProtocol {
    private let fetcher: APIFetcherProtocol
    private let decoder: ResponseHandlerProtocol
    
    init(fetcher: APIFetcherProtocol = APIFetcherManager(),
         decoder: ResponseHandlerProtocol = ResponseHandler()) {
        self.fetcher = fetcher
        self.decoder = decoder
    }
    
    func fetch<T: Codable>(method: HTTPMethods = .get) async throws -> T {
        let url = "https://jsonplaceholder.typicode.com/albums?userId=10"
        do {
            let data = try await fetcher.fetching(url: url, method: method)
            return try await decoder.decodeResponse(type: T.self, data: data)
        } catch let error as CustomError {
            throw error
        } catch {
            throw CustomError.unknownError
        }
    }
}



