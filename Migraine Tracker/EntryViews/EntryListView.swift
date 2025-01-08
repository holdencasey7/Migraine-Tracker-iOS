import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isEntryDetailVisible: Bool
    @State private var selectedSortMethod: EntrySortPickerView.SortMethod = .timestampDescending
    @State private var presentCalendarSheet: Bool = false
    @State private var selectedEntry: Entry? = nil  // Tracks the selected entry for navigation
    
    var entries: [Entry]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Left-Aligned Calendar Button
                    HStack {
                        Button(action: { presentCalendarSheet = true }) {
                            Image(systemName: "calendar.circle")
                                .font(.system(size: 40))
                                .padding(3)
                        }
                        .sheet(isPresented: $presentCalendarSheet) {
                            EntryCalendarView(entries: entries, isPresented: $presentCalendarSheet)
                        }
                        Spacer()
                    }
                    
                    // Centered Sort Picker
                    HStack {
                        Spacer()
                        Text("SORT BY: ")
                            .font(Font.custom("Avenir", size: 17))
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
        }
        .background(Color("FirstLightPink"))
        .edgesIgnoringSafeArea(.all)
    }
}
