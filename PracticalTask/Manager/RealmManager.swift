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
}


final class RealmManager: RealmManagerProtocol {
    
    private func createRealm() -> Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save<T: Object>(_ objects: [T], update: Bool = false) {
        let realm = createRealm() // Create a Realm instance on the current thread
        do {
            try realm.write {
                realm.add(objects, update: update ? .modified : .error)
            }
        } catch {
            print("Failed to save objects to Realm: \(error.localizedDescription)")
        }
    }
    
    func fetch<T: Object>(_ type: T.Type, filter: NSPredicate?) -> [T] {
        let realm = createRealm() // Create a Realm instance on the current thread
        var results = realm.objects(type.self)
        if let filter = filter {
            results = results.filter(filter)
        }
        return Array(results)
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        let realm = createRealm() // Create a Realm instance on the current thread
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch {
            print("Failed to delete objects from Realm: \(error.localizedDescription)")
        }
    }
    
    
}
