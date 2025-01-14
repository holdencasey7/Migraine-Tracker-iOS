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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(appContainer) // Comes from SwiftDataAppContainer
    }
}
