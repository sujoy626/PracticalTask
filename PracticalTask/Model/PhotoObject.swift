//
//  PhotoObject.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//


import RealmSwift
import Foundation


class PhotoObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var apiID: Int
    @Persisted var albumID: Int
    @Persisted var title: String
    @Persisted var thumbnailURL: String
    @Persisted var url: String
    
    convenience init(apiID: Int, albumID: Int, title: String, thumbnailURL: String, url: String) {
        self.init()
        self.apiID = apiID
        self.albumID = albumID
        self.title = title
        self.thumbnailURL = thumbnailURL
    }
}


struct PhotoDataModel:Identifiable,Hashable{
    let id = UUID()
    let apiID: Int
    let albumID : Int
    let title: String
    let thumbnailURL: String
    let url: String
}
