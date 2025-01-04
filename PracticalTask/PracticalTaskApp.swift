//
//  PracticalTaskApp.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import SwiftUI

@main
struct PracticalTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            AlbumListView()
        }
    }
}
