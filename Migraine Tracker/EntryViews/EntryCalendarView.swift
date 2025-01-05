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
                    EntryListView(isEntryDetailVisible: $isEntryDetailPresented, entries: filteredEntries)
                        .padding(.top, 15)
                    if !isEntryDetailPresented {
                        Button(action: {
                            isEntryDetailPresented = false
                            showingEntries = false
                            self.selectedDate = nil
                        }) {
                            Text("DONE")
                            .kerning(3)
                            .font(Font.custom("Avenir", size: 19))
                            .padding(5)
                            .padding(.trailing, 39)
                            .padding(.leading, 39)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.85))
                            )
                        }
                        .padding(.bottom, 15)
                    }
                }
                .background(isEntryDetailPresented ? Color.white.edgesIgnoringSafeArea(.all) : Color("FirstLightPink").edgesIgnoringSafeArea(.all))
                
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
