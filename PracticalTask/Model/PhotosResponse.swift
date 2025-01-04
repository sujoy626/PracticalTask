//
//  PhotosResponse.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Foundation

// MARK: - PhotosResponseElement
struct PhotosResponse: Codable,Identifiable,Hashable {
    let id = UUID()
    let albumID: Int?
    let title: String?
    let url, thumbnailURL: String?
    let apiID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case title, url
        case thumbnailURL = "thumbnailUrl"
        case apiID = "id"
    }
}
