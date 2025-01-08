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
                
                Tab("Add Migraine", systemImage: "plus.square", value: 1) {
                    AddEntryView()
                }
                
                Tab("Migraines", systemImage: "chevron.up.chevron.down.square", value: 2) {
                    EntriesView()
                }
                Tab("Insights", systemImage: "chart.bar", value: 3) {
                    InsightsView()
                }
            }
        }
        .background(Color("FirstLightPink"))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
