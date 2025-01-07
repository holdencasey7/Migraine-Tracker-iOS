//
//  EditEntryView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI
import SwiftData

struct EditEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var triggers: [Trigger]
    @Query var treatments: [Treatment]
    @Query var symptoms: [Symptom]
    
    @Binding var isPresented: Bool
    @Binding var entry: Entry
    
    @State var date: Date
    @State var intensity: Double
    @State var notes: String
    
    @State var finalSelectedTriggers: [Trigger]
    @State var finalSelectedTreatments: [Treatment]
    @State var finalSelectedSymptoms: [Symptom]
    
    @State var presentTriggerSheet: Bool = false
    @State var presentTreatmentSheet: Bool = false
    @State var presentSymptomSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("EDIT MIGRAINE ENTRY")
                    .font(Font.custom("Avenir", size: 20))
                    .padding()
                    .padding(.bottom, -10)
                    .padding(.top, -10)
                    .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 10)
            VStack (alignment: .leading, spacing: -10) {
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
                    Spacer()
                }
                HStack {
                    Text("Intensity:")
                        .font(Font.custom("Avenir", size: 19))
                        .padding()
                    CustomIntensitySliderView(value: $intensity)
//                        .padding()
//                        .frame(width: 200)
                    IntensityIconView(intensity: Int(intensity))
                        .padding()
                }
            }
            .padding(.bottom, 35)
            VStack {
                VStack(alignment: .center) {
                    Button(action: { presentSymptomSheet = true}) {
                        HStack {
                            Image(systemName: "pencil.circle")
                            Text("SYMPTOMS")
                                .kerning(3)
                        }
                    }
                    .kerning(3)
                    .font(Font.custom("Avenir", size: 19))
                    .padding(5)
                    .padding(.trailing, 50)
                    .padding(.leading, 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                    )
                    .sheet(isPresented: $presentSymptomSheet) {
                        SymptomSelectableGridView(symptoms: symptoms, finalSelectedSymptoms: $finalSelectedSymptoms, selectedSymptoms: entry.symptoms, isPresented: $presentSymptomSheet)
                    }
                    GenericHorizontalScrollTileView(items: finalSelectedSymptoms)
                    .frame(minHeight:60, maxHeight: 100)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                }
                VStack(alignment: .center) {
                    Button(action: { presentTriggerSheet = true }) {
                        HStack {
                            Image(systemName: "pencil.circle")
                            Text("TRIGGERS")
                                .kerning(3)
                        }
                    }
                    .kerning(3)
                    .font(Font.custom("Avenir", size: 19))
                    .padding(5)
                    .padding(.trailing, 50)
                    .padding(.leading, 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.85))
                    )
                    .sheet(isPresented: $presentTriggerSheet) {
                        TriggerSelectableMenuView( triggers: triggers, selectedTriggers: finalSelectedTriggers, finalSelectedTriggers: $finalSelectedTriggers, isPresented: $presentTriggerSheet)
                    }
                    GenericHorizontalScrollTileView(items: finalSelectedTriggers)
                        .frame(minHeight:60, maxHeight: 100)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                }
                VStack(alignment: .center) {
                    Button(action: { presentTreatmentSheet = true }) {
                        HStack {
                            Image(systemName: "pencil.circle")
                            Text("TREATMENTS")
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
                    .sheet(isPresented: $presentTreatmentSheet) {
                        TreatmentSelectableMenuView( treatments: treatments, selectedTreatments: finalSelectedTreatments, finalSelectedTreatments: $finalSelectedTreatments, isPresented: $presentTreatmentSheet)
                    }
                    GenericIconlessHorizontalScrollRowView(items: finalSelectedTreatments)
                    .frame(minHeight:60)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                }
                HStack (/*alignment: .leading,*/ spacing: -25){
                    Text("Notes:")
                        .font(Font.custom("Avenir", size: 19))
                        .padding()
                        .padding(.leading, 10)
                    TextField("Notes", text: $notes)
                        .padding()
                        .submitLabel(.done)
                }
                .padding(.top, 15)
            }
            Spacer()
            HStack {
                Spacer()
                Button("SAVE CHANGES") {
                    entry.triggers = finalSelectedTriggers
                    entry.treatments = finalSelectedTreatments
                    entry.symptoms = finalSelectedSymptoms
                    entry.notes = notes
                    entry.intensity = Int(intensity)
                    entry.timestamp = date
                    
                    try? modelContext.save()
                    entry = modelContext.model(for: entry.id) as! Entry
                    
                    date = Date()
                    intensity = 1.0
                    notes = ""
                    finalSelectedTriggers.removeAll()
                    finalSelectedTreatments.removeAll()
                    finalSelectedSymptoms.removeAll()
                    
                    isPresented = false
                }
                .padding()
                .font(Font.custom("Avenir", size: 25))
                Spacer()
                Button("CANCEL") {
                    isPresented = false
                    //                    try? modelContext.rollback()
                }
                .padding()
                .font(Font.custom("Avenir", size: 25))
                Spacer()
            }
        }
        .background(Image("FirstPinkAttempt").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
    }
}

//#Preview {
//    EditEntryView(isPresented: .constant(false))
//}
