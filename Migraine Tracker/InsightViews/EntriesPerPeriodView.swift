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

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(groupedEntries, id: \.0) { (period, count) in
                        HStack {
                            Text(period)
                                .font(.headline)
                            Spacer()
                            Text("\(count)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    EntriesPerPeriodView(entries: [])
}
