//
//  EntryListFromCalendarView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/6/25.
//

import SwiftUI
import SwiftData

struct EntryListFromCalendarView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isEntryDetailVisible: Bool
    @Binding var showingEntries: Bool
    @Binding var selectedDate: Date?
    @State var selectedSortMethod: EntrySortPickerView.SortMethod = .timestampDescending
    @State private var selectedEntry: Entry? = nil  // Tracks the selected entry for navigation
    
    var entries: [Entry]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Left-Aligned Calendar Button
                    HStack {
                        Button(action: {
                            isEntryDetailVisible = false
                            showingEntries = false
                            self.selectedDate = nil
                        }) {
                            Image(systemName: "arrow.left.circle")
                                .font(.system(size: 40))
                                .padding(3)
                        }
                        Spacer()
                    }
                    
                    // Centered Sort Picker
                    HStack {
                        Spacer()
                        Text("SORT BY: ")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .kerning(1)
                        EntrySortPickerView(selectedSortMethod: $selectedSortMethod)
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .background(Color("FirstLightPink"))
                .padding(.bottom, -10)
                
                List {
                    ForEach(entries.sorted(by: selectedSortMethod.sortClosure)) { entry in
                        Button {
                            selectedEntry = entry
                            isEntryDetailVisible = true
                        } label: {
                            HStack {
                                EntryRowView(entry: entry)
                                Spacer()
                                Image(systemName: "chevron.right") // Standard disclosure indicator
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete((entries.sorted(by: selectedSortMethod.sortClosure))[index])
                            try? modelContext.save()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(.bottom, 100)
            }
            .background(Color("FirstLightPink"))
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $isEntryDetailVisible) {
                if let selectedEntry = selectedEntry {
                    EntryDetailView(entry: selectedEntry, isEntryDetailVisible: $isEntryDetailVisible)
                }
            }
            .background(Color("FirstLightPink"))
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color("FirstLightPink"))
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    EntryListView(isEntryDetailVisible: .constant(false), entries: [
//        .init(timestamp: Date(), intensity: 1, notes: "1"),
//        .init(timestamp: Date(), intensity: 2, notes: "2"),
//        .init(timestamp: Date(), intensity: 3, notes: "3"),
//        .init(timestamp: Date(), intensity: 4, notes: "4"),
//        .init(timestamp: Date(), intensity: 5, notes: "5")
//    ])
//}
