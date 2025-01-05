//
//  APIEndPoints.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

protocol URLComponent {
    var endPoint : String { get }
}

extension URLComponent {
    var path : String {
        ""
    }
    
    var baseURL : String {
        "https://jsonplaceholder.typicode.com/"
    }
    
    var url : String {
        baseURL + path + endPoint
    }
    
}

enum APIURLItemType {
    case getAlbums(query: String)
    case getPhotos(query: String)
}


extension APIURLItemType : URLComponent {
    var endPoint : String {
        switch self {
        case .getAlbums(let query):
            return "albums" + query
        case .getPhotos(let query):
            return "photos" + query
        }
    }
}
