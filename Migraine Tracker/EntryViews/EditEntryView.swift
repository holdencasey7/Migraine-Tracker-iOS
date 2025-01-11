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
    
    @State var treatmentNotes: [TreatmentNote]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack (alignment: .leading, spacing: -10) {
                    HStack {
                        Text("Start Date:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(01)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .padding()
                        Spacer()
                        DatePicker("", selection: $date)
                            .frame(width: geometry.size.width / 3)
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Text("Intensity:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(1)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .padding()
                        CustomIntensitySliderView(value: $intensity)
                            .frame(width: geometry.size.width / 2)
                        IntensityIconView(intensity: Int(intensity))
                            .padding()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 8)
                .padding(.bottom)
                VStack (alignment: .center) {
                    VStack(alignment: .center) {
                        Button(action: { presentSymptomSheet = true}) {
                            HStack {
                                Image(systemName: "pencil.circle")
                                Text("SYMPTOMS")
                                    .kerning(Constants.subtitleKerning)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                            }
                            .frame(width: geometry.size.width / 1.5)
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentSymptomSheet) {
                            SymptomSelectableGridView(symptoms: symptoms, finalSelectedSymptoms: $finalSelectedSymptoms, selectedSymptoms: entry.symptoms, isPresented: $presentSymptomSheet)
                        }
                        GenericHorizontalScrollTileView(items: finalSelectedSymptoms)
                            .padding(.horizontal)
                        Spacer(minLength: 0)
                    }
                    .frame(height: geometry.size.height / 5)
                    VStack(alignment: .center) {
                        Button(action: { presentTriggerSheet = true }) {
                            HStack {
                                Image(systemName: "pencil.circle")
                                Text("TRIGGERS")
                                    .kerning(Constants.subtitleKerning)
                            }
                            .frame(width: geometry.size.width / 1.5)
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentTriggerSheet) {
                            TriggerSelectableMenuView( triggers: triggers, selectedTriggers: finalSelectedTriggers, finalSelectedTriggers: $finalSelectedTriggers, isPresented: $presentTriggerSheet)
                        }
                        GenericHorizontalScrollTileView(items: finalSelectedTriggers)
                            .padding(.horizontal)
                        Spacer(minLength: 0)
                    }
                    .frame(height: geometry.size.height / 5)
                    VStack(alignment: .center) {
                        Button(action: { presentTreatmentSheet = true }) {
                            HStack {
                                Image(systemName: "pencil.circle")
                                Text("TREATMENTS")
                                    .kerning(Constants.subtitleKerning)
                            }
                            .frame(width: geometry.size.width / 1.5)
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentTreatmentSheet) {
                            TreatmentSelectableMenuView( treatments: treatments, selectedTreatments: finalSelectedTreatments, finalSelectedTreatments: $finalSelectedTreatments, isPresented: $presentTreatmentSheet, treatmentNotes: treatmentNotes, finalTreatmentNotes: $treatmentNotes)
                        }
                        GenericIconlessHorizontalScrollRowView(items: finalSelectedTreatments)
                            .padding(.horizontal)
                    }
                    .frame(height: geometry.size.height / 8)
                    HStack (spacing: -25){
                        Text("Notes:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .padding()
                        TextField("Notes", text: $notes)
                            .padding()
                            .submitLabel(.done)
                    }
                    .frame(height: geometry.size.height / 10)
                    Spacer()
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
                        entry.setTreatmentNotes(treatmentNotes)
                        
                        if let followup = entry.followup {
                            followup.ratings.forEach { rating in
                                if let treatment = rating.treatment {
                                    if !entry.treatments.contains(treatment) {
                                        modelContext.delete(rating)
                                    }
                                }
                            }
                        }
                        
                        try? modelContext.save()
                        entry = modelContext.model(for: entry.id) as! Entry
                        
                        date = Date()
                        intensity = 1.0
                        notes = ""
                        finalSelectedTriggers.removeAll()
                        finalSelectedTreatments.removeAll()
                        finalSelectedSymptoms.removeAll()
                        treatmentNotes.removeAll()
                        
                        isPresented = false
                    }
                    .padding()
                    .font(Font.custom("Avenir", size: Constants.addEntrySubmitButtonFontSize))
                    Spacer()
                    Button("CANCEL") {
                        isPresented = false
                    }
                    .padding()
                    .font(Font.custom("Avenir", size: 25))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .frame(width: geometry.size.width)
            .background(Image("FirstPinkAttempt").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
        }
    }
}

//#Preview {
//    EditEntryView(isPresented: .constant(false))
//}
