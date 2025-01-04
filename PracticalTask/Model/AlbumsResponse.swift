//
//  AlbumsResponse.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Foundation

struct AlbumsResponse: Codable,Identifiable,Hashable {
    let id = UUID()
    let apiID: Int
    let userID : Int
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case title
        case apiID = "id"
    }
}
