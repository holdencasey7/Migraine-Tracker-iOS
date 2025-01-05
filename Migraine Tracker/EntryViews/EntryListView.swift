//
//  EntryListView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isEntryDetailVisible: Bool
    @State var selectedSortMethod: EntrySortPickerView.SortMethod = .timestampDescending
    
    var entries: [Entry]
    var body: some View {
        VStack {
            if !isEntryDetailVisible {
                HStack {
                    Text("SORT BY: ")
                        .font(Font.custom("Avenir", size: 17))
                        .kerning(1)
                    EntrySortPickerView(selectedSortMethod: $selectedSortMethod)
                }
            }
            NavigationStack {
                    List {
                        ForEach(entries.sorted(by: selectedSortMethod.sortClosure)) { entry in
                            NavigationLink(destination: EntryDetailView(entry: entry, isEntryDetailVisible: $isEntryDetailVisible)) {
                                EntryRowView(entry: entry)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete((entries.sorted(by: selectedSortMethod.sortClosure))[index])
                                try? modelContext.save()
                            }
                        }
                    }
                    .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
                    .scrollContentBackground(.hidden)
            }
        }
        .background(Color("FirstLightPink").edgesIgnoringSafeArea(.all))
    }
}

//#Preview {
//    EntryListView(entries: [.init(timestamp: Date(), intensity: 1, notes: "1"), .init(timestamp: Date(), intensity: 2, notes: "2"), .init(timestamp: Date(), intensity: 3, notes: "3"), .init(timestamp: Date(), intensity: 4, notes: "4"), .init(timestamp: Date(), intensity: 5, notes: "5")])
//}
