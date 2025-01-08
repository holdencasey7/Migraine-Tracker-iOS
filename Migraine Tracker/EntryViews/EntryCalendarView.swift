//
//  EntryCalendarView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/30/24.
//

import SwiftUI
import SwiftData

struct EntryCalendarView: View {
    var entries: [Entry]
    @State private var selectedDate: Date? = nil
    @State private var showingEntries = false
    @State private var isEntryDetailPresented = false
    @Binding var isPresented: Bool
    var body: some View {
        CalendarView(entries: entries, selectedDate: $selectedDate, showingEntries: $showingEntries)
        .frame(maxHeight: 500)
        .sheet(isPresented: Binding(
            get: { showingEntries && selectedDate != nil },
            set: { showingEntries = $0 }
        )) {
            if let selectedDate = selectedDate {
                let filteredEntries = entries.filter {
                    Calendar.current.isDate($0.timestamp, inSameDayAs: selectedDate)
                }
                VStack {
                    EntryListFromCalendarView(isEntryDetailVisible: $isEntryDetailPresented, showingEntries: $showingEntries, selectedDate: $selectedDate, entries: filteredEntries)
                }
                .background(Color("FirstLightPink"))
                
            }
        }
        Button("Done") {
            isPresented = false
        }
    }
}

//#Preview {
//    EntryCalendarView(entries: [.init(timestamp: Date(), intensity: 1, notes: "1"), .init(timestamp: Date(), intensity: 2, notes: "2"), .init(timestamp: Date(), intensity: 3, notes: "3"), .init(timestamp: Date(), intensity: 4, notes: "4"), .init(timestamp: Date(), intensity: 5, notes: "5")])
//}
