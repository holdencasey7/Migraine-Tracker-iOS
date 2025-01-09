//
//  Entry.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/27/24.
//

import Foundation
import SwiftData
import WeatherKit

@Model
final class Entry:Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var intensity: Int
    @Relationship(deleteRule: .nullify) var triggers: [Trigger]
    @Relationship(deleteRule: .nullify) var symptoms: [Symptom]
    @Relationship(deleteRule: .nullify) var treatments: [Treatment]
    @Relationship(deleteRule: .cascade) var treatmentNotes: [TreatmentNote]
    var notes: String
    @Relationship(deleteRule: .cascade) var followup: Followup?
    var temperature: Double?
    var condition: WeatherCondition?
    var pressure: Double?
    var humidity: Double?
    var pressureTrend: PressureTrend?
    var conditionSymbol: String?
    
    var duration: TimeInterval? {
            guard let followup = followup else { return nil }
            return followup.endDate.timeIntervalSince(timestamp)
    }
    
    
    init(timestamp: Date, intensity: Int, triggers: [Trigger], symptoms: [Symptom], treatments: [Treatment], treatmentNotes: [TreatmentNote] = [],notes: String, temperature: Double? = nil, condition: WeatherCondition? = nil, pressure: Double? = nil, humidity: Double? = nil, pressureTrend: PressureTrend? = nil, conditionSymbol: String? = nil) {
        self.id = UUID()
        
        if intensity < Constants.minIntensity {
            self.intensity = Constants.minIntensity
        } else if intensity > Constants.maxIntensity {
            self.intensity = Constants.maxIntensity
        } else {
            self.intensity = intensity
        }
        
        self.timestamp = timestamp

        self.triggers = triggers
        self.symptoms = symptoms
        self.treatments = treatments
        self.treatmentNotes = treatmentNotes
        self.notes = notes
        
        self.temperature = temperature
        self.condition = condition
        self.pressure = pressure
        self.humidity = humidity
        self.pressureTrend = pressureTrend
        self.conditionSymbol = conditionSymbol
        
        self.treatmentNotes.forEach { treatmentNote in
            treatmentNote.entryIn = self
        }
    }
    
    convenience init(timestamp: Date, intensity: Int, notes: String) {
        let triggers: [Trigger] = []
        let symptoms: [Symptom] = []
        let treatments: [Treatment] = []
        self.init(timestamp: timestamp, intensity: intensity, triggers: triggers, symptoms: symptoms, treatments: treatments, notes: notes)
    }
}

enum TimeGranularity {
    case day, week, month
}

func groupEntries(entries: [Entry], by granularity: TimeGranularity) -> [(String, Int)] {
    let calendar = Calendar.current
    
    // Debug: Log number of entries
    print("Number of entries: \(entries.count)")
    
    let groupedEntries: [String: Int]
    switch granularity {
    case .day:
        print("Grouping entries by day...")
        groupedEntries = Dictionary(grouping: entries, by: {
            let startOfDay = calendar.startOfDay(for: $0.timestamp)
            let formatted = formattedDate(startOfDay)
            // Debug: Log the date being used for grouping
            print("Start of day for entry \($0.timestamp): \(formatted)")
            return formatted
        })
        .mapValues { $0.count }
    case .week:
        print("Grouping entries by week...")
        groupedEntries = Dictionary(grouping: entries, by: {
            guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: $0.timestamp)?.start else {
                let formatted = formattedDate($0.timestamp)
                print("No week interval found for \($0.timestamp), using date: \(formatted)")
                return formatted
            }
            let formatted = formattedDate(startOfWeek)
            print("Start of week for entry \($0.timestamp): \(formatted)")
            return formatted
        })
        .mapValues { $0.count }
    case .month:
        print("Grouping entries by month...")
        groupedEntries = Dictionary(grouping: entries, by: {
            guard let startOfMonth = calendar.dateInterval(of: .month, for: $0.timestamp)?.start else {
                let formatted = formattedDate($0.timestamp)
                print("No month interval found for \($0.timestamp), using date: \(formatted)")
                return formatted
            }
            let formatted = formattedDate(startOfMonth)
            print("Start of month for entry \($0.timestamp): \(formatted)")
            return formatted
        })
        .mapValues { $0.count }
    }
    
    // Debug: Log the grouped entries before sorting
    print("Grouped entries before sorting: \(groupedEntries)")

    // Convert dictionary to sorted array of tuples
    let sortedEntries = groupedEntries.sorted { $0.key < $1.key }
    
    // Debug: Log the sorted entries
    print("Sorted entries: \(sortedEntries)")

    return sortedEntries
}

// Helper function to format Date to a String
func formattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"  // Customize the format to suit your needs
    let formatted = dateFormatter.string(from: date)
    
    // Debug: Log the formatted date
    print("Formatted date: \(formatted)")
    return formatted
}

// Helper function to determine granularity
func determineGranularity(entries: [Entry]) -> TimeGranularity {
    guard let firstDate = entries.min(by: { $0.timestamp < $1.timestamp })?.timestamp,
          let lastDate = entries.max(by: { $0.timestamp < $1.timestamp })?.timestamp else {
        print("No entries available, defaulting to .day granularity.")
        return .day // Default to day if no entries
    }
    
    let timeInterval = lastDate.timeIntervalSince(firstDate)
    
    // Debug: Log the time interval between the first and last entry
    print("Time interval between first and last entries: \(timeInterval) seconds")
    
    if timeInterval < 7 * 24 * 60 * 60 { // Less than a week
        print("Granularity determined as .day")
        return .day
    } else if timeInterval < 30 * 24 * 60 * 60 { // Less than a month
        print("Granularity determined as .week")
        return .week
    } else { // More than a month
        print("Granularity determined as .month")
        return .month
    }
}
