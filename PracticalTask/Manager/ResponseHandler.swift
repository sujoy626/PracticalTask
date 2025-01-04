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
            let decodedData = try JSONDecoder().decode(T.self, from: data)
//            return .success(decodedData)
            return decodedData
        } catch {
//            return .failure(CustomError.decodingError(message: error.localizedDescription))
            throw CustomError.decodingError(message: error.localizedDescription)
        }
    }
}





