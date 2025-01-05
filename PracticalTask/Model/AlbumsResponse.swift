//
//  AlbumsResponse.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

struct AlbumsResponse: Codable {
    let id: Int
    let userID : Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
