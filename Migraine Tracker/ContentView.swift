//
//  ContentView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0

    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            TabView(selection: $selection) {
                Tab("Home", systemImage: "house", value: 0) {
                    HomeView(contentViewSelection: $selection)
                }
                Tab("Migraines", systemImage: "chevron.up.chevron.down.square", value: 1) {
                    EntriesView()
                }
                Tab("Add Migraine", systemImage: "plus.square", value: 2) {
                    AddEntryView()
                }
                Tab("Insights", systemImage: "chart.bar", value: 3) {
                    InsightsView()
                }
                Tab("Settings", systemImage: "gear", value: 4) {
                    SettingsView()
                }
            }
        }
        .background(selection == 0 ? Color("MediumPink") : selection == 3 ? Color("LightBlue") : Color("FirstLightPink"))
        .animation(.easeInOut(duration: 0.5), value: selection) // Smooth background transition
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}



#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
