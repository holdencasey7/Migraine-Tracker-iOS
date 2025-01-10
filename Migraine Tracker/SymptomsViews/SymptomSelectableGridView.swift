//
//  SymptomSelectableGridView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI

struct SymptomSelectableGridView: View {
    var symptoms: [Symptom]
    @Binding var finalSelectedSymptoms: [Symptom]
    @State var selectedSymptoms: [Symptom]
    @Binding var isPresented: Bool
    let columnLayout = Array(repeating: GridItem(alignment: .top), count: 3)
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(symptoms.sorted(by: { $0.title < $1.title})) { symptom in
                        // TODO: change to two grids where the icon moves between them (LinkedIn video tutorial)
                        VStack {
                            SymptomTileView(symptom: symptom)
                                .padding()
                                .onTapGesture {
                                    if selectedSymptoms.contains(symptom) {
                                        selectedSymptoms.remove(at: selectedSymptoms.firstIndex(of: symptom)!)
                                    } else {
                                        selectedSymptoms.append(symptom)
                                    }
                                    
                                }
                        } .background(selectedSymptoms.contains(symptom) ? Color("LightGrey") : Color.clear)
                            .background(in: RoundedRectangle(cornerRadius: 10))
                    }
                    AddSymptomTileView()
                        .padding()
                }
            }
            Button(action: {
                finalSelectedSymptoms = selectedSymptoms
                isPresented = false
            }) {
                Text("SAVE")
            }
            .font(Font.custom("Avenir", size: Constants.addEntrySubmitButtonFontSize))
            .padding()
        }
    }
}

//#Preview {
//    SymptomSelectableGridView()
//}
