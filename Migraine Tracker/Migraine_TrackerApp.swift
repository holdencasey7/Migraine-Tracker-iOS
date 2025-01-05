//
//  Migraine_TrackerApp.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/27/24.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct Migraine_TrackerApp: App {
//    var models: [any PersistentModel.Type] = [Entry.self, Trigger.self, Treatment.self]

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(appContainer) // Comes from SwiftDataAppContainer
    }
}
