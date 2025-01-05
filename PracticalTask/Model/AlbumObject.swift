//
//  AlbumObject.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import RealmSwift
import Foundation




class AlbumObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var apiID: Int
    @Persisted var userID: Int
    @Persisted var title: String
    
    convenience init(apiID: Int, userID: Int?, title: String?) {
            self.init()
            self.apiID = apiID
            self.userID = userID ?? 0
            self.title = title ?? "Untitled"
        }
}


struct AlbumDataModel:Identifiable,Hashable{
    let id = UUID()
    let apiID: Int
    let userID : Int
    let title: String
    let photos: [PhotoDataModel]
}
