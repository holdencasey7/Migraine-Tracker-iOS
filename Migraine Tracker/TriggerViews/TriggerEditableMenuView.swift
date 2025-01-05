//
//  TriggerEditableMenuView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI
import SwiftData

struct TriggerEditableMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var triggers: [Trigger]
    
    @Binding var isPresented: Bool
    @State var presentAddTriggerSheet: Bool = false
    
    @State private var searchText: String = ""
    @State private var filteredTriggers: [Trigger] = []
    
    @State private var updater: Bool = false
    
    var body: some View {
        NavigationStack {
            List(TriggerCategory.allCases) { category in
                Section {
                    let sectionTriggers = filteredTriggers.filter({$0.category == category}).sorted(by: { $0.title < $1.title })
                    ForEach(sectionTriggers) { trigger in
                        TriggerRowView(trigger: trigger)
                    }
                    .onDelete(perform: {
                        for index in $0 {
                            let triggerToDelete = sectionTriggers[index]
                            deleteItems(triggerToDelete: triggerToDelete)
                        }
                    })
                } header: {
                    Text(category.rawValue)
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    filteredTriggers = triggers
                } else {
                    filteredTriggers = triggers.filter({$0.title.lowercased().starts(with: searchText.lowercased())})
                }
            }
            .onChange(of: updater) {
                filteredTriggers = triggers
            }
            .onAppear {
                filteredTriggers = triggers
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Trigger", systemImage: "plus")
                    }
                    .sheet(isPresented: $presentAddTriggerSheet) {
                        TriggerCreationView(isPresented: $presentAddTriggerSheet)
                    }
                }
            }
        }
        Button("Done") {
            isPresented = false
        }
        .font(.title2)
        .padding(5)
        .padding(.trailing, 10)
        .padding(.leading, 10)
        .background(Color("LightGrey"), in: RoundedRectangle(cornerRadius: 10))
    }

    private func addItem() {
        presentAddTriggerSheet = true
    }

    private func deleteItems(triggerToDelete: Trigger) {
        withAnimation {
            modelContext.delete(triggerToDelete)
        }
        try? modelContext.save()
        updater.toggle()
    }
}

//#Preview {
//    TriggerEditableMenuView()
//}
