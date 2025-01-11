//
//  TreatmentMenuView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/30/24.
//

import SwiftUI

struct TreatmentSelectableMenuView: View {
    var treatments: [Treatment]
    @State var selectedTreatments: [Treatment]
    @Binding var finalSelectedTreatments: [Treatment]
    @Binding var isPresented: Bool
    
    @State private var searchText = ""
    @State var filteredTreatments: [Treatment] = []
    
    @State var isShowingTreatmentNotes: Bool = false
    @State var selectedTreatmentForNotes: Treatment? = nil
    @State var treatmentNotes: [TreatmentNote]
    @Binding var finalTreatmentNotes: [TreatmentNote]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                List(TreatmentCategory.allCases) { category in
                    Section {
                        ForEach(filteredTreatments.filter({$0.category == category}).sorted(by: { $0.title < $1.title
                        })) { treatment in
                            let selected = selectedTreatments.contains(treatment)
                            HStack{
                                TreatmentRowView(treatment: treatment)
                                    .frame(height: geometry.size.width * 0.15)
                                Spacer()
                                if selected {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("PrettyPink"))
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {tapGesture in
                                if !selected {
                                    selectedTreatments.append(treatment)
                                } else {
                                    selectedTreatments.removeAll(where: { $0 == treatment })
                                }
                            }
                            .swipeActions {
                                Button("Notes") {
//                                    selectedTreatmentForNotes = treatment // Has bug
                                    isShowingTreatmentNotes = true
                                }
                                .tint(.blue)
                            }
                        }
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
                .onAppear {
                    filteredTreatments = treatments
                }
            }
            .sheet(isPresented: $isShowingTreatmentNotes) {
                Text("Hello")
//                if let selectedTreatmentForNotes {
//                    // Rethink how to do this
////                    let treatmentNote
////                    treatmentNotes.append(TreatmentNote(treatment: selectedTreatmentForNotes))
////                    CreateTreatmentNoteView(treatmentNote: selectedTreatmentForNotes, allEntryTreatmentNotes: $treatmentNotes, isPresented: $isShowingTreatmentNotes)
//                    Text(selectedTreatmentForNotes.title)
//                } else {
//                    Text("No Treatment Selected")
//                }
            }
        }
        HStack {
            Spacer()
            Button(action: saveTreatments) {
                Text("SAVE")
            }
            .font(Font.custom("Avenir", size: Constants.addEntrySubmitButtonFontSize))
            .padding()
            Spacer()
        }
    }
    private func saveTreatments() {
        finalSelectedTreatments = selectedTreatments
        treatmentNotes.forEach { treatmentNote in
            if let treatmentIn = treatmentNote.treatmentIn {
                if finalSelectedTreatments.contains(treatmentIn) {
                    finalTreatmentNotes.append(treatmentNote)
                }
            }
        }
        isPresented = false
    }
}

//#Preview {
//    TreatmentMenuView()
//}
