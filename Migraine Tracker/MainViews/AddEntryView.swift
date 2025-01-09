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
    
    @State private var submitInProgress = false
    @StateObject var weatherViewModel = WeatherViewModel()
    @State private var errorMessage: String?
    
    @State private var showSuccessPopup = false
    
    @State var treatmentNotes: [TreatmentNote] = []
    
    var body: some View {
//        ScrollView {
            VStack {
//                Text("NEW MIGRAINE ENTRY")
//                    .font(Font.custom("Avenir", size: 20))
//                    .padding()
//                    .padding(.bottom, -10)
//                    .padding(.top, -10)
//                    .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
                Spacer()
                VStack (alignment: .leading, spacing: -10){
                    HStack {
                        Text("Start Date:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
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
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .padding()
                        CustomIntensitySliderView(value: $intensity)
                        IntensityIconView(intensity: Int(intensity))
                            .padding()
                    }
                    .padding(.bottom, 15)
                }
                .padding(.leading, 10)
                VStack (alignment: .center) {
                    VStack(alignment: .center) {
                        Button(action:{ presentSymptomSheet = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("SYMTPOMS")
                                    .kerning(Constants.subtitleKerning)
                            }
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .padding(.trailing, 50)
                        .padding(.leading, 50)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentSymptomSheet) {
                            SymptomSelectableGridView(symptoms: symptoms, finalSelectedSymptoms: $finalSelectedSymptoms, selectedSymptoms: finalSelectedSymptoms, isPresented: $presentSymptomSheet)
                        }
                        GenericHorizontalScrollTileView(items: finalSelectedSymptoms)
                        //                        .frame(minHeight:60)
                            .padding(.vertical, 5)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                    }
                    VStack(alignment: .center) {
                        Button(action: { presentTriggerSheet = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("TRIGGERS")
                                    .kerning(Constants.subtitleKerning)
                                
                            }
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .foregroundStyle(Color.black)
                        .padding(5)
                        .padding(.trailing, 57)
                        .padding(.leading, 57)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentTriggerSheet) {
                            TriggerSelectableMenuView( triggers: triggers, selectedTriggers: finalSelectedTriggers, finalSelectedTriggers: $finalSelectedTriggers, isPresented: $presentTriggerSheet)
                        }
                        GenericHorizontalScrollTileView(items: finalSelectedTriggers)
                        //                        .frame(minHeight:60)
                            .padding(.vertical, 5)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                    }
                    VStack(alignment: .center) {
                        Button(action: { presentTreatmentSheet = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("TREATMENTS")
                                    .kerning(Constants.subtitleKerning)
                                
                            }
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .padding(.trailing, 39)
                        .padding(.leading, 39)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.addEntryViewButtonRoundedRectangleCornerRadius)
                                .fill(Color.white.opacity(Constants.addEntryViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentTreatmentSheet) {
                            TreatmentSelectableMenuView( treatments: treatments, selectedTreatments: finalSelectedTreatments, finalSelectedTreatments: $finalSelectedTreatments, isPresented: $presentTreatmentSheet)
                        }
                        GenericIconlessHorizontalScrollRowView(items: finalSelectedTreatments)
//                                                .frame(minHeight:60)
                            .padding(.vertical, 5)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                    }
                    HStack (spacing: -25){
                        Text("Notes:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .padding()
                            .padding(.leading, 10)
                        TextField("Notes", text: $notes)
                            .padding()
                            .submitLabel(.done)
                    } .padding(.top, 5)
                }
                Spacer()
                Button("ADD ENTRY") {
                    Task {
                        await submit()
                    }
                    showSuccessPopup = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        date = Date()
                        intensity = 1.0
                        notes = ""
                        finalSelectedTriggers.removeAll()
                        finalSelectedTreatments.removeAll()
                        finalSelectedSymptoms.removeAll()
                        submitInProgress = false
                    }
                }
                .padding(10)
                .padding(.bottom, 10)
                .font(Font.custom("Avenir", size: 25))
                .disabled(submitInProgress)
//                .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 10))
            }
//        }
        .background(Image("FirstPinkAttempt").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
        .overlay(AddedEntryPopupView(isVisible: $showSuccessPopup))
    }
    
    private func submit() async {
        submitInProgress = true
        errorMessage = nil  // Reset error message
    
        let entry = Entry(timestamp: date, intensity: Int(intensity), triggers: finalSelectedTriggers, symptoms: finalSelectedSymptoms, treatments: finalSelectedTreatments, treatmentNotes: treatmentNotes, notes: notes)
            // Make sure I don't need to add treatmentNotes.entry = entry
            // SwiftData should(?) take care of it
        weatherViewModel.requestLocationUpdate()
        
        await weatherViewModel.fetchWeather() { success in
            if success {
                entry.temperature = weatherViewModel.temperature
                entry.condition = weatherViewModel.condition
                entry.pressure = weatherViewModel.pressure
                entry.humidity = weatherViewModel.humidity
                entry.pressureTrend = weatherViewModel.pressureTrend
                entry.conditionSymbol = weatherViewModel.conditionSymbol
            } else {
                errorMessage = "Failed to fetch weather data."
            }
        }
        
        modelContext.insert(entry)
        try? modelContext.save()
    }
}

#Preview {
    AddEntryView()
}
