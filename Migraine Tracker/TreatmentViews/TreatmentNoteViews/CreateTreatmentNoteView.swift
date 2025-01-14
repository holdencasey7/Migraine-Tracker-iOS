//
//  CreateTreatmentNoteView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/9/25.
//

import SwiftUI

struct CreateTreatmentNoteView: View {
    var treatment: Treatment
    @Binding var allEntryTreatmentNotes: [TreatmentNote]
    @Binding var isPresented: Bool
    
    @State var dosage: String = ""
    @State var frequency: Int = 1
    @State var datesTaken: [Date] = []
    @State var duration: TimeInterval = .zero
    @State var otherNotes: String = ""
    
    @State var showDosage: Bool = false
    @State var showFrequency: Bool = false
    @State var showDuration: Bool = false
    @State var showOtherNotes: Bool = false
    
    private let ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    
    let timeUnits = ["Seconds", "Minutes", "Hours"]
    @State private var timeAmount: Double = 0
    @State private var selectedTimeUnit: String = "Seconds"
    
    var body: some View {
        VStack {
            Text("Notes for \(treatment.title)")
                .font(Font.custom("Avenir", size: Constants.headerFontSize))
                .kerning(Constants.subtitleKerning)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .padding()
            
            Form {
                Section {
                    Toggle("Record Dosage?", isOn: $showDosage)
                        .padding(.horizontal)
                    if showDosage {
                        TextField("Dosage", text: $dosage)
                            .autocapitalization(.none)
                            .padding()
                            .submitLabel(.done)
                    }
                } header: {
                    Text("Dosage")
                        .font(Font.custom("Avenir", size: Constants.treatmentNotesCreationViewSectionHeaderFontSize))
                        .kerning(Constants.treatmentNotesCreationViewSectionHeaderKerning)
                }

                Section {
                    Toggle("Record Times Taken?", isOn: $showFrequency)
                        .padding(.horizontal)
                    if showFrequency {
                        Stepper("Times Taken: \(frequency)", value: $frequency, in: 0...10)
                            .padding(.horizontal)
                            .onChange(of: frequency) { oldValue, newValue in
                                if newValue > oldValue {
                                    let additionalDates = newValue - datesTaken.count
                                    datesTaken.append(contentsOf: Array(repeating: Date(), count: additionalDates))
                                } else if newValue < oldValue {
                                    datesTaken.removeLast(datesTaken.count - newValue)
                                }
                            }
                        ForEach(0..<datesTaken.count, id: \.self) { index in
                            DatePicker("\(ordinalFormatter.string(from: NSNumber(value: index + 1)) ?? "") Time:", selection: $datesTaken[index])
                                .padding()
                        }
                    }
                } header: {
                    Text("Times Taken")
                        .font(Font.custom("Avenir", size: Constants.treatmentNotesCreationViewSectionHeaderFontSize))
                        .kerning(Constants.treatmentNotesCreationViewSectionHeaderKerning)
                }
                
                Section {
                    Toggle("Record Duration?", isOn: $showDuration)
                        .padding(.horizontal)
                    if showDuration {
                        HStack {
                            TextField("Duration", value: $timeAmount, format: .number)
                                .keyboardType(.decimalPad)
                            Picker("", selection: $selectedTimeUnit) {
                                ForEach(timeUnits, id: \.self) { unit in
                                    Text(unit)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding()
                        .onChange(of: selectedTimeUnit) {
                            updateTimeInterval()
                        }
                        .onChange(of: timeAmount) {
                            updateTimeInterval()
                        }
                    }
                } header: {
                    Text("Duration")
                        .font(Font.custom("Avenir", size: Constants.treatmentNotesCreationViewSectionHeaderFontSize))
                        .kerning(Constants.treatmentNotesCreationViewSectionHeaderKerning)
                }
                
                Section {
                    TextField("Other notes", text: $otherNotes)
                        .autocapitalization(.none)
                        .padding()
                        .submitLabel(.done)
                } header: {
                    Text("Other Notes")
                        .font(Font.custom("Avenir", size: Constants.treatmentNotesCreationViewSectionHeaderFontSize))
                        .kerning(Constants.treatmentNotesCreationViewSectionHeaderKerning)
                    
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("Blue1"))
            Button(action: submit) {
                Text("SUBMIT")
                    .font(Font.custom("Avenir", size: Constants.headerFontSize))
                    .kerning(Constants.subtitleKerning)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                            .fill(Color("FirstButtonPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
                    )
            }
        }
        .background(Color("Blue1"))
        .onAppear {
            let previousNote = allEntryTreatmentNotes.first { $0.treatmentIn == treatment }
            if let previousNote {
                if previousNote.dosage != nil {
                    dosage = previousNote.dosage!
                    showDosage = true
                }
                if previousNote.frequency != nil && previousNote.frequency != 0 {
                    frequency = previousNote.frequency!
                    showFrequency = true
                    if previousNote.datesTaken != nil && !previousNote.datesTaken!.isEmpty {
                        datesTaken = previousNote.datesTaken!
                    }
                }
                if previousNote.duration != nil && previousNote.duration != .zero {
                    duration = previousNote.duration!
                    showDuration = true
                }
                if previousNote.otherNotes != nil {
                    otherNotes = previousNote.otherNotes!
                }
            } else {
                dosage = treatment.defaultDosage ?? ""
                frequency = treatment.defaultFrequency ?? 1
                duration = treatment.defaultDurartion ?? .zero
                otherNotes = treatment.defaultOtherNotes ?? ""
                datesTaken = [Date()]
            }
        }
    }
    
    private func submit() {
        datesTaken.sort()
//        if !datesTaken.isEmpty {
//            datesTaken.removeFirst()
//        }
        if let index = allEntryTreatmentNotes.firstIndex(where: { $0.treatmentIn == treatment }) {
            if showDosage {
                print("Updating dosage")
                allEntryTreatmentNotes[index].dosage = dosage
            } else {
                allEntryTreatmentNotes[index].dosage = nil
            }
    
            if showFrequency {
                print("Updating frequency")
                allEntryTreatmentNotes[index].frequency = frequency
                allEntryTreatmentNotes[index].datesTaken = datesTaken
            } else {
                allEntryTreatmentNotes[index].frequency = nil
                allEntryTreatmentNotes[index].datesTaken = nil
            }

            if showDuration {
                print("Updating duration")
                allEntryTreatmentNotes[index].duration = duration
            } else {
                allEntryTreatmentNotes[index].duration = nil
            }
            allEntryTreatmentNotes[index].otherNotes = otherNotes
        } else {
            let treatmentNote: TreatmentNote = TreatmentNote(treatmentIn: treatment)
            
            if showDosage {
                print("Updating dosage")
                treatmentNote.dosage = dosage
            } else {
                treatmentNote.dosage = nil
            }
    
            if showFrequency {
                print("Updating frequency")
                treatmentNote.frequency = frequency
                treatmentNote.datesTaken = datesTaken
            } else {
                treatmentNote.frequency = nil
                treatmentNote.datesTaken = nil
            }

            if showDuration {
                print("Updating duration")
                treatmentNote.duration = duration
            } else {
                treatmentNote.duration = nil
            }
            treatmentNote.otherNotes = otherNotes
            allEntryTreatmentNotes.append(treatmentNote)
        }
        isPresented = false
    }

    private func updateTimeInterval() {
        switch selectedTimeUnit {
        case "Seconds":
            duration = timeAmount
        case "Minutes":
            duration = timeAmount * 60
        case "Hours":
            duration = timeAmount * 3600
        default:
            duration = timeAmount
        }
    }
}



//#Preview {
//    CreateTreatmentNoteView()
//}
