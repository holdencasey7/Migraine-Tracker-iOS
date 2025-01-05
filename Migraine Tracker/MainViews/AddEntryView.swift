//
//  AddEntryView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/27/24.
//

import SwiftUI
import SwiftData

struct AddEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var triggers: [Trigger]
    @Query var treatments: [Treatment]
    @Query var symptoms: [Symptom]
    
    @State var date: Date = Date()
    @State var intensity = 1.0
    @State var notes: String = ""
    
    @State var finalSelectedTriggers: [Trigger] = []
    @State var finalSelectedTreatments: [Treatment] = []
    @State var finalSelectedSymptoms: [Symptom] = []
    
    @State var presentTriggerSheet: Bool = false
    @State var presentTreatmentSheet: Bool = false
    @State var presentSymptomSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("NEW MIGRAINE ENTRY")
                .font(Font.custom("Avenir", size: 20))
                .padding()
                .padding(.bottom, -10)
                .padding(.top, -10)
                .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
            VStack (alignment: .leading, spacing: -10){
                HStack {
                    Text("Start Date:")
                        .font(Font.custom("Avenir", size: 19))
                        .padding()
                    DatePicker("", selection: $date
                               // If only want date and no time:
                               //, displayedComponents: .date
                    )
//                    .padding()
                    .padding(.trailing, 50)
                }
                HStack {
                    Text("Intensity:")
                        .font(Font.custom("Avenir", size: 19))
                        .padding()
                    CustomIntensitySliderView(value: $intensity)
                    IntensityIconView(intensity: Int(intensity))
                        .padding()
                }
                .padding(.bottom, 25)
            }
            .padding(.leading, 10)
            VStack (alignment: .center) {
                VStack(alignment: .center) {
                    Button(action:{ presentSymptomSheet = true }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("SYMTPOMS")
                                .kerning(3)
                            
                        }
                    }
                    .font(Font.custom("Avenir", size: 19))
                    .padding(5)
                    .padding(.trailing, 50)
                    .padding(.leading, 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                    )
                    .sheet(isPresented: $presentSymptomSheet) {
                        SymptomSelectableGridView(symptoms: symptoms, finalSelectedSymptoms: $finalSelectedSymptoms, selectedSymptoms: finalSelectedSymptoms, isPresented: $presentSymptomSheet)
                    }
                    GenericHorizontalScrollTileView(items: finalSelectedSymptoms)
                        .frame(minHeight:60)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
                VStack(alignment: .center) {
                    Button(action: { presentTriggerSheet = true }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("TRIGGERS")
                                .kerning(3)
                            
                        }
                    }
                    .font(Font.custom("Avenir", size: 19))
                    .foregroundStyle(Color.black)
                    .padding(5)
                    .padding(.trailing, 57)
                    .padding(.leading, 57)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                    )
                    .sheet(isPresented: $presentTriggerSheet) {
                        TriggerSelectableMenuView( triggers: triggers, selectedTriggers: finalSelectedTriggers, finalSelectedTriggers: $finalSelectedTriggers, isPresented: $presentTriggerSheet)
                    }
                    GenericHorizontalScrollTileView(items: finalSelectedTriggers)
                        .frame(minHeight:60)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
                VStack(alignment: .center) {
                    Button(action: { presentTreatmentSheet = true }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("TREATMENTS")
                                .kerning(3)
                            
                        }
                    }
                    .font(Font.custom("Avenir", size: 19))
                    .padding(5)
                    .padding(.trailing, 39)
                    .padding(.leading, 39)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                    )
                    .sheet(isPresented: $presentTreatmentSheet) {
                        TreatmentSelectableMenuView( treatments: treatments, selectedTreatments: finalSelectedTreatments, finalSelectedTreatments: $finalSelectedTreatments, isPresented: $presentTreatmentSheet)
                    }
                    GenericIconlessHorizontalScrollRowView(items: finalSelectedTreatments)
                        .frame(minHeight:60)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                }
                HStack (spacing: -25){
                    Text("Notes:")
                        .font(Font.custom("Avenir", size: 19))
                        .padding()
                        .padding(.leading, 10)
                    TextField("Notes", text: $notes)
                        .padding()
                        .submitLabel(.done)
                } .padding(.top, 15)
            }
            Spacer()
            Button("ADD ENTRY") {
                let entry = Entry(timestamp: date, intensity: Int(intensity), triggers: finalSelectedTriggers, symptoms: finalSelectedSymptoms, treatments: finalSelectedTreatments, notes: notes)
                modelContext.insert(entry)
                try? modelContext.save()
                date = Date()
                intensity = 1.0
                notes = ""
                finalSelectedTriggers.removeAll()
                finalSelectedTreatments.removeAll()
                finalSelectedSymptoms.removeAll()
            }
            .padding()
            .font(Font.custom("Avenir", size: 25))
        }
        .background(Image("FirstPinkAttempt").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
    }
}

#Preview {
    AddEntryView()
}
