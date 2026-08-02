//
//  PracticeDemoApp.swift
//  PracticeDemo
//
//  Created by KMSOFT on 14/05/26.
//

import SwiftUI
import CoreData

@main
struct PracticeDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
