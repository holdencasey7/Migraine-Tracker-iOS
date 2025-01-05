//
//  TreatmentEditableMenuView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI
import SwiftData

struct TreatmentEditableMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var treatments: [Treatment]
    
    @Binding var isPresented: Bool
    @State var presentAddTreatmentSheet: Bool = false
    
    @State private var searchText: String = ""
    @State private var filteredTreatments: [Treatment] = []
    
    @State private var updater: Bool = false

    var body: some View {
        NavigationStack {
            List(TreatmentCategory.allCases) { category in
                Section {
                    let sectionTreatments = filteredTreatments.filter({$0.category == category}).sorted(by: {$0.title < $1.title})
                    ForEach(sectionTreatments) { treatment in
                        TreatmentRowView(treatment: treatment)
                    }
                    .onDelete(perform: {
                        for index in $0 {
                            let treatmentToDelete = sectionTreatments[index]
                            deleteItems(treatmentToDelete: treatmentToDelete)
                        }
                    })
                } header: {
                    Text(category.rawValue)
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    filteredTreatments = treatments
                } else {
                    filteredTreatments = treatments.filter({$0.title.lowercased().starts(with: searchText.lowercased())})
                }
            }
            .onChange(of: updater) {
                filteredTreatments = treatments
            }
            .onAppear {
                filteredTreatments = treatments
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Treatment", systemImage: "plus")
                    }
                    .sheet(isPresented: $presentAddTreatmentSheet) {
                        TreatmentCreationView(isPresented: $presentAddTreatmentSheet)
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
        presentAddTreatmentSheet = true
    }

    private func deleteItems(treatmentToDelete: Treatment) {
        withAnimation {
            modelContext.delete(treatmentToDelete)
        }
        try? modelContext.save()
        updater.toggle()
    }
}

//#Preview {
//    TreatmentEditableMenuView()
//}
