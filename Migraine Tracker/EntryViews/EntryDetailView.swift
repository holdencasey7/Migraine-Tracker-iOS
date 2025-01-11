//
//  EntryView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI
import SwiftData

struct EntryDetailView: View {
    // Where to put constants?
    let maxIntensity: Int = 5
    let minIntensity: Int = 1
    
    @Environment(\.modelContext) var modelContext
    @State var presentDeleteAlert: Bool = false
    @State var presentEditSheet: Bool = false
    @State var presentFollowupSheet: Bool = false
    @State var entry: Entry
    @Binding var isEntryDetailVisible: Bool
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Text("Migraine on \(entry.timestamp, formatter: dateFormatter)")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .onAppear { isEntryDetailVisible = true }
                    .onDisappear { isEntryDetailVisible = false }
                IntensityFractionView(intensity: entry.intensity)
                    .frame(maxWidth: geometry.size.width / 3)
                
                if !entry.notes.isEmpty {
                    ScrollView {
                        Text(entry.notes)
                            .font(Font.custom("Avenir", size: Constants.bodyFontSize))
                            .minimumScaleFactor(0.8)
                            .lineLimit(3)
                            .allowsTightening(true)
                            .padding()
                    }
                    .frame(height: geometry.size.height / 10)
                }
//                Spacer()
                HStack {
//                    Spacer()
                    VStack {
                        Text("SYMPTOMS")
                            .modifier(EntryDetailSTTHeaderStyle())
                        GenericListView(items: entry.symptoms)
                    }
                    .padding(.horizontal)
//                    .layoutPriority(0.5)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 4)
//                    Spacer()
                    VStack {
                        Text("TRIGGERS")
                            .modifier(EntryDetailSTTHeaderStyle())
                        GenericListView(items: entry.triggers)
                    }
//                    .layoutPriority(0.5)
                    .padding(.horizontal)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 4)
//                    Spacer()
                }
                VStack {
                    Text("TREATMENTS")
                        .modifier(EntryDetailSTTHeaderStyle())
                    GenericIconlessHorizontalScrollRowView(items: entry.treatments)
                        .padding(.horizontal)
                    Spacer()
                }
                .frame(height: geometry.size.height / 8)
                WeatherView(temperature: entry.temperature, pressure: entry.pressure, condition: entry.condition, humidity: entry.humidity, pressureTrend: entry.pressureTrend, conditionSymbol: entry.conditionSymbol)
                    .padding()
                    .frame(maxWidth: .infinity)
                    
                HStack {
                    Spacer()
                    Button(action: editEntry) {
                        Text("EDIT")
                            .modifier(RoundedPinkButtonStyle())
                    }
//                    .padding(.leading, 40)
                    .sheet(isPresented: $presentEditSheet) {
                        EditEntryView(isPresented: $presentEditSheet, entry: $entry, date: entry.timestamp, intensity: Double(entry.intensity), notes: entry.notes, finalSelectedTriggers: entry.triggers, finalSelectedTreatments: entry.treatments, finalSelectedSymptoms: entry.symptoms, treatmentNotes: entry.treatmentNotes)
                    }
                    Spacer()
                    Button(action: {presentFollowupSheet = true}) {
                        Text("FOLLOW UP")
                            .modifier(RoundedPinkButtonStyle())
                    }
                    .sheet(isPresented: $presentFollowupSheet) {
                        let whichFollowup: Int = pickFollowupView(entry: entry)
                        if whichFollowup == 0 {
                            FollowupDetailView(followup: entry.followup!)
                        } else if whichFollowup == 1 {
                            UpdateFollowupView(followup: entry.followup!, newEndDate: entry.followup!.endDate, isPresented: .constant(true))
                        } else if whichFollowup == 2 {
                            CreateFollowupView(entry: $entry)
                        }
                    }
                    Spacer()
                    Button(action: {presentDeleteAlert = true}) {
                        Image(systemName: "trash")
                            .modifier(RoundedPinkButtonStyle())
                            .foregroundStyle(Color.black)
                    }
//                    .padding(.trailing, 40)
                    .alert("Delete entry?", isPresented: $presentDeleteAlert) {
                        Button("No", role: .cancel){}
                        Button("Yes", role: .destructive) { deleteEntry() }
                    }
                    Spacer()
                }
                Spacer()
                
            }
            .frame(width: geometry.size.width)
        }
    }
    private func deleteEntry() {
        modelContext.delete(entry)
        try? modelContext.save()
        isEntryDetailVisible = false
    }
    private func editEntry() {
        presentEditSheet = true
    }
    
    private func pickFollowupView(entry: Entry) -> Int {
        if let followup = entry.followup {
            var hasNewTreatment = false
            var existingRatedTreatments: [Treatment] = []
            followup.ratings.forEach { rating in
                existingRatedTreatments.append(rating.treatment ?? .init(title: "Error Treatment", icon: "", category: .other))
            }
            entry.treatments.forEach { treatment in
                if !existingRatedTreatments.contains(treatment) {
                    hasNewTreatment = true
                }
            }
            if hasNewTreatment {
                return 1
            } else {
                return 0
            }
        } else {
            return 2
        }
    }
}

#Preview {
    EntryDetailView(entry: .init(timestamp: Date(), intensity: 3, notes: "with notes"), isEntryDetailVisible: .constant(true))
}
