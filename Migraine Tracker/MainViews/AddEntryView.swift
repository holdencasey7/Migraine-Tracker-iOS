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
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer()
                VStack (alignment: .leading, spacing: -10){
                    HStack {
                        Text("Start Date:")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(1)
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
                        Button(action:{ presentSymptomSheet = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("SYMTPOMS")
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
                            SymptomSelectableGridView(symptoms: symptoms, finalSelectedSymptoms: $finalSelectedSymptoms, selectedSymptoms: finalSelectedSymptoms, isPresented: $presentSymptomSheet)
                        }
                        GenericHorizontalScrollTileView(items: finalSelectedSymptoms)
                            .padding(.horizontal)
                        Spacer(minLength: 0)
                    }
                    .frame(height: geometry.size.height / 5)
                    VStack(alignment: .center) {
                        Button(action: { presentTriggerSheet = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("TRIGGERS")
                                    .kerning(Constants.subtitleKerning)
                            }
                            .frame(width: geometry.size.width / 1.5)
                        }
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .foregroundStyle(Color.black)
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
                                Image(systemName: "plus.circle")
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
                            treatmentNotes.removeAll()
                        }
                    }
                    .padding()
                    .font(Font.custom("Avenir", size: Constants.addEntrySubmitButtonFontSize))
                    .disabled(submitInProgress)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .frame(width: geometry.size.width)
            .background(Image("FirstPinkAttempt").resizable().edgesIgnoringSafeArea(.all).aspectRatio(contentMode: .fill))
            .overlay(AddedEntryPopupView(isVisible: $showSuccessPopup))
        }
    }
    
    private func submit() async {
        submitInProgress = true
        errorMessage = nil  // Reset error message
    
        let entry = Entry(timestamp: date, intensity: Int(intensity), triggers: finalSelectedTriggers, symptoms: finalSelectedSymptoms, treatments: finalSelectedTreatments, treatmentNotes: treatmentNotes, notes: notes)

        // If date is within 1 hour of current date
        if areDatesWithinOneHour(date, Date()) {
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
        }
        
        modelContext.insert(entry)
        do {
            try modelContext.save()
        } catch {
            print(error)
        }
    }
    
    func areDatesWithinOneHour(_ date1: Date, _ date2: Date) -> Bool {
        let timeDifference = abs(date1.timeIntervalSince(date2))
        return timeDifference <= 3600 // 3600 seconds = 1 hour
    }
}

#Preview {
    let container = try! ModelContainer(for: Trigger.self, Treatment.self, Symptom.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    // Adding sample data
    let sampleTriggers = [
        Trigger(title: "Stress", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
        Trigger(title: "Poor Sleep", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
        Trigger(title: "Irregular Meals", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
        Trigger(title: "Physical Exertion", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
        Trigger(title: "Weather", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
        Trigger(title: "Lights", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
        Trigger(title: "Smells", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
        Trigger(title: "Noise", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
        Trigger(title: "Caffeine", icon: "DietTriggerIcon", category: TriggerCategory.diet),
        Trigger(title: "Alcohol", icon: "DietTriggerIcon", category: TriggerCategory.diet),
        Trigger(title: "MSG", icon: "DietTriggerIcon", category: TriggerCategory.diet),
        Trigger(title: "Nitrates", icon: "DietTriggerIcon", category: TriggerCategory.diet),
        Trigger(title: "Chocolate", icon: "DietTriggerIcon", category: TriggerCategory.diet),
        Trigger(title: "Medication", icon: "DefaultTriggerIcon", category: TriggerCategory.other),
        Trigger(title: "Hormones", icon: "DefaultTriggerIcon", category: TriggerCategory.other),
    ]
    let sampleTreatments = [
        Treatment(title: "Other Painkillers", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
        Treatment(title: "Excedrin", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
        Treatment(title: "Midol", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
        Treatment(title: "Triptan", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
        Treatment(title: "Herbal Tea", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
        Treatment(title: "Caffeine", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
        Treatment(title: "Steam", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
    ]
    let sampleSymptoms = [
        Symptom(title: "Headache", icon: "HeadacheSymptomIcon"),
        Symptom(title: "Nausea", icon: "NauseaSymptomIcon"),
        Symptom(title: "Vision Loss", icon: "VisionLossSymptomIcon"),
        Symptom(title: "Dizziness", icon: "DizzinessSymptomIcon"),
        Symptom(title: "Neck Pain", icon: "NeckPainSymptomIcon"),
        Symptom(title: "Fatigue", icon: "FatigueSymptomIcon"),
        Symptom(title: "Numbness", icon: "NumbnessSymptomIcon")
    ]

    AddEntryView()
        .onAppear {
            sampleTriggers.forEach { container.mainContext.insert($0) }
            sampleTreatments.forEach { container.mainContext.insert($0) }
            sampleSymptoms.forEach { container.mainContext.insert($0) }
        }
        .environment(\.modelContext, container.mainContext)
}

