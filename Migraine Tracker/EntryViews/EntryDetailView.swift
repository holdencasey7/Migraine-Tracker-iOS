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
        VStack(spacing: 10) {
            
//            Spacer()
            Text("Migraine on \(entry.timestamp, formatter: dateFormatter)")
                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                .fontWeight(.bold)
                .onAppear { isEntryDetailVisible = true }
                .onDisappear { isEntryDetailVisible = false }
            IntensityFractionView(intensity: entry.intensity)

            if !entry.notes.isEmpty {
                ScrollView {
                    let notes = entry.notes.isEmpty ? "No notes" : entry.notes
                    Text("\(notes)")
                        .font(Font.custom("Avenir", size: 15))
                        .padding()
                }
                .frame(maxHeight: 100)
            }
            HStack {
                Spacer()
                VStack {
                    Text("SYMPTOMS")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .kerning(Constants.subtitleKerning)
                    GenericListView(items: entry.symptoms)
                }
                .layoutPriority(0.5)
                .frame(maxWidth: .infinity)
                Spacer()
                VStack {
                    Text("TRIGGERS")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .kerning(Constants.subtitleKerning)
                    GenericListView(items: entry.triggers)
                }
                .layoutPriority(0.5)
                .frame(maxWidth: .infinity)
                Spacer()
            }
            VStack {
                Text("TREATMENTS")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    .kerning(Constants.subtitleKerning)
                GenericIconlessHorizontalScrollRowView(items: entry.treatments)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                Spacer()
            }
            WeatherView(temperature: entry.temperature, pressure: entry.pressure, condition: entry.condition, humidity: entry.humidity, pressureTrend: entry.pressureTrend, conditionSymbol: entry.conditionSymbol)
                .padding()
            HStack {
                Button(action: editEntry) {
                    Text("EDIT")
                        .kerning(3)
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                                .fill(Color("FirstLightPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
                        )
                }
                .padding(.leading, 40)
                .sheet(isPresented: $presentEditSheet) {
                    EditEntryView(isPresented: $presentEditSheet, entry: $entry, date: entry.timestamp, intensity: Double(entry.intensity), notes: entry.notes, finalSelectedTriggers: entry.triggers, finalSelectedTreatments: entry.treatments, finalSelectedSymptoms: entry.symptoms)
                }
                Spacer()
                Button(action: {presentFollowupSheet = true}) {
                    Text("FOLLOWUP")
                        .kerning(3)
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                                .fill(Color("FirstLightPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
                        )
                        .sheet(isPresented: $presentFollowupSheet) {
                            AllTypesFollowupView(entry: $entry, isPresented: $presentFollowupSheet, followup: entry.followup)
                        }
                }
                Spacer()
                Button(action: {presentDeleteAlert = true}) {
                    Image(systemName: "trash")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .padding(5)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                                .fill(Color("FirstLightPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
                        )
                        .foregroundStyle(Color.black)
                }
                .padding(.trailing, 40)
                .alert("Delete entry?", isPresented: $presentDeleteAlert) {
                    Button("No", role: .cancel){}
                    Button("Yes", role: .destructive) { deleteEntry() }
                }
            }
            Spacer()
            
        }
    }
    private func deleteEntry() {
        modelContext.delete(entry)
        isEntryDetailVisible = false
    }
    private func editEntry() {
        presentEditSheet = true
    }
}

#Preview {
    EntryDetailView(entry: .init(timestamp: Date(), intensity: 3, notes: "with notes"), isEntryDetailVisible: .constant(true))
}
