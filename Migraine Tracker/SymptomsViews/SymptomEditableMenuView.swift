//
//  SymptomEditableMenuView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/21/25.
//

import SwiftUI
import SwiftData

struct SymptomEditableMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var symptoms: [Symptom]
    
    @State var presentAddSymptomSheet: Bool = false
    
    @State private var searchText: String = ""
    @State private var filteredSymptoms: [Symptom] = []
    
    @State private var updater: Bool = false
    
    var body: some View {
        NavigationStack {
            let shownSymptoms = filteredSymptoms.sorted(by: {$0.title < $1.title})
            List {
                ForEach(shownSymptoms) { symptom in
                    GenericRowView(item: symptom)
                }
                .onDelete(perform: {
                    for index in $0 {
                        let symptomToDelete = shownSymptoms[index]
                        deleteItems(symptomToDelete: symptomToDelete)
                    }
                })
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    filteredSymptoms = symptoms
                } else {
                    filteredSymptoms =
                    symptoms.filter({$0.title.lowercased().starts(with: searchText.lowercased())})
                }
            }
            .onChange(of: updater) {
                filteredSymptoms = symptoms
            }
            .onAppear {
                filteredSymptoms = symptoms
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Symptom", systemImage: "plus")
                    }
                    .sheet(isPresented: $presentAddSymptomSheet) {
                        SymptomCreationView(isPresented: $presentAddSymptomSheet)
                    }
                }
            }
        }
    }
    
    private func addItem() {
        presentAddSymptomSheet = true
    }

    private func deleteItems(symptomToDelete: Symptom) {
        withAnimation {
            modelContext.delete(symptomToDelete)
        }
        try? modelContext.save()
        updater.toggle()
    }
}

//#Preview {
//    SymptomEditableMenuView()
//}
