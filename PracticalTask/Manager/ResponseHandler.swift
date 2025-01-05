//
//  ResponseHandler.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//



import Foundation

protocol ResponseHandlerProtocol {
    func decodeResponse<T:Codable>(type : T.Type,data: Data) async throws -> T
}


class ResponseHandler : ResponseHandlerProtocol {
    func decodeResponse<T:Codable>(type : T.Type,data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CustomError.decodingError(message: error.localizedDescription)
        }
    }
}





