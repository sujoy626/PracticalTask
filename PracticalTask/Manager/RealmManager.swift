//
//  RealmManager.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import RealmSwift
import Foundation

protocol RealmManagerProtocol {
    func save<T: Object>(_ objects: [T], update: Bool) 
    func fetch<T: Object>(_ type: T.Type, filter: NSPredicate?) -> [T]
    func deleteAll<T: Object>(_ type: T.Type)
    func insertDummyDataIfNeeded()
}

final class RealmManager: RealmManagerProtocol {
    
    private let realm: Realm

    init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save<T: Object>(_ objects: [T], update: Bool = false) {
        do {
            try realm.write {
                realm.add(objects, update: update ? .modified : .error)
            }
        } catch {
            print("Failed to save objects to Realm: \(error.localizedDescription)")
        }
    }
    
    func fetch<T: Object>(_ type: T.Type, filter: NSPredicate? = nil) -> [T] {
        var results = realm.objects(type)
        if let filter = filter {
            results = results.filter(filter)
        }
        return Array(results)
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch {
            print("Failed to delete objects from Realm: \(error.localizedDescription)")
        }
    }
    
    func insertDummyDataIfNeeded() {
        let existingAlbums = fetch(AlbumsObject.self)
        if existingAlbums.isEmpty {
            let dummyAlbums = [
                AlbumsObject.init(apiID: 1, userID: 1, title: "Test Album 1"),
                AlbumsObject.init(apiID: 2, userID: 2, title: "Test Album 2"),
                AlbumsObject.init(apiID: 3, userID: 3, title: "Test Album 3"),
            ]
            save(dummyAlbums)
        }
    }
}
