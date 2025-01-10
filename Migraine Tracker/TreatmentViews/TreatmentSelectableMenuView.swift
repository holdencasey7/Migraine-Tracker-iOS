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
                        }
                    } header: {
                        Text(category.rawValue)
                    }
                } .searchable(text: $searchText)
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
        }
        HStack {
            Spacer()
            Button(action: saveTreatments) {
                Text("Save")
            }
            .font(.title2)
            .padding(5)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            .background(Color("LightGrey"), in: RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
    }
    private func saveTreatments() {
        finalSelectedTreatments = selectedTreatments
        isPresented = false
    }
}

//#Preview {
//    TreatmentMenuView()
//}
