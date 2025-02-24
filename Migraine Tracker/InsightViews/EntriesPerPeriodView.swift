//
//  MonthlyMigrainesView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 2/16/25.
//

import SwiftUI

struct EntriesPerPeriodView: View {
    var entries: [Entry]
    
    let monthFormat: String = "MMMM yyyy"
    let weekFormat: String = "M/d/yy"
    
    @State private var selectedGranularity: TimeGranularity = .month

    var body: some View {
        let format = selectedGranularity == .month ? formatDateMonthly : formatDateWeekly
        let groupedEntries = groupEntries(entries: entries, by: selectedGranularity, formattedDate: format)
            .sorted { parseDate($0.0) > parseDate($1.0) }
        

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
                            Text(period)
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
    
    func formatDateMonthly(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = monthFormat
        return dateFormatter.string(from: date)
    }
    
    func formatDateWeekly(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = weekFormat
        let startOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: date)!
        let endOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: 0, to: date)! - 1
        return dateFormatter.string(from: startOfWeek) + " - " + dateFormatter.string(from: endOfWeek)
    }
    
    func parseDate(_ date: String) -> Date {
        if selectedGranularity == .month {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = monthFormat
            let date = dateFormatter.date(from: date)
            return date ?? Date()
        }
        else if selectedGranularity == .week {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = weekFormat
            let firstDate = date.split(separator: "-")[0].trimmingCharacters(in: .whitespaces)
            let date = dateFormatter.date(from: firstDate)
            return date ?? Date()
        }
        else {
            return Date()
        }
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
