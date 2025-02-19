//
//  MonthlyMigrainesView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 2/16/25.
//

import SwiftUI

struct EntriesPerPeriodView: View {
    var entries: [Entry]
    
    @State private var selectedGranularity: TimeGranularity = .month

    var body: some View {
        let groupedEntries = groupEntries(entries: entries, by: selectedGranularity)
            .sorted { $0.0 > $1.0 } // Sort descending (most recent first)

        VStack {
            Picker("Period", selection: $selectedGranularity) {
                Text("Monthly").tag(TimeGranularity.month)
                Text("Weekly").tag(TimeGranularity.week)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            // Add sort (descending or ascending, date or frequency)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Try to make more similar to EntryList
                    ForEach(groupedEntries, id: \.0) { (period, count) in
                        HStack {
                            // Say name of month year
                            // Week: "2/1/25 - 2/8/25"
                            //                            Text(period)
                            Text("December 2025")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.8)
                                .lineLimit(2)
                                .allowsTightening(true)
                            Spacer()
                            Text("\(count) Migraines")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.8)
                                .lineLimit(2)
                                .allowsTightening(true)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                            // If clicked, goes to EntryList of those migraines
                        }
                        .padding()
                        .background(in: RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
        .background(Color("FirstLightPink"))
    }
}

#Preview {
    let entries: [Entry] = [
        Entry(timestamp: Date().addingTimeInterval(-86400 * 5), intensity: 3, notes: ""), // 5 days ago
        Entry(timestamp: Date().addingTimeInterval(-86400 * 10), intensity: 5, triggers: [], symptoms: [], treatments: [], notes: ""),
        Entry(timestamp: Date().addingTimeInterval(-86400 * 15), intensity: 2, notes: ""),
        Entry(timestamp: Date().addingTimeInterval(-86400 * 20), intensity: 4, notes: ""),
        Entry(timestamp: Date().addingTimeInterval(-86400 * 25), intensity: 1, notes: "")
    ]
    EntriesPerPeriodView(entries: entries)
}
