import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isEntryDetailVisible: Bool
    @State var selectedSortMethod: EntrySortPickerView.SortMethod = .timestampDescending
    @State var presentCalendarSheet: Bool = false
    
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
                                .padding(5)
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
                .scrollContentBackground(.hidden)
                .padding(.bottom, 100)
            }
            .background(Color("FirstLightPink"))
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color("FirstLightPink"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    EntryListView(isEntryDetailVisible: .constant(false), entries: [
        .init(timestamp: Date(), intensity: 1, notes: "1"),
        .init(timestamp: Date(), intensity: 2, notes: "2"),
        .init(timestamp: Date(), intensity: 3, notes: "3"),
        .init(timestamp: Date(), intensity: 4, notes: "4"),
        .init(timestamp: Date(), intensity: 5, notes: "5")
    ])
}
