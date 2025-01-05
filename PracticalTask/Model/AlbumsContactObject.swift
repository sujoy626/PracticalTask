//
//  AlbumsContactObject.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import RealmSwift
import Foundation




class AlbumsObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var apiID: Int
    @Persisted var userID: Int
    @Persisted var title: String
}


struct AlbumDataModel:Identifiable,Hashable{
    let id = UUID()
    let apiID: Int
    let userID : Int
    let title: String
    
}
