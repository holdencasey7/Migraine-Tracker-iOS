//
//  Treatment.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import Foundation
import SwiftData

@Model
final class Treatment:Identifiable, Hashable, GenericTriggerTreatmentSymptom{
    @Attribute(.unique) var id: UUID
    var title: String
    var icon: String?
    var category: TreatmentCategory
    @Relationship(deleteRule: .nullify, inverse: \Entry.treatments) var entriesIn: [Entry] = []
    @Relationship(deleteRule: .cascade) var ratings: [Rating] = []
    
    @Relationship(deleteRule: .cascade) var treatmentNotes: [TreatmentNote] = []
    var defaultDosage: String?
    var defaultFrequency: Int?
//    var defaultTimeFirstTaken: Date? How would the time ever be a default other than Date()
    var defaultDurartion: TimeInterval?
    var defaultOtherNotes: String?
    
    
    var averageRating: Double? {
        let validRatings = ratings.filter { $0.ratingValue != 0 } // Exclude ratings with value 0
        guard !validRatings.isEmpty else { return nil }
        let total = validRatings.reduce(0.0) { $0 + Double($1.ratingValue) }
        return total / Double(validRatings.count)
    }
    
    init(title: String?, icon: String?, category: TreatmentCategory) {
        self.id = UUID()
        
        if let title = title {
            self.title = title
        } else {
            self.title = "Untitled Treatment"
        }
        
        self.icon = icon
        self.category = category
    }
}

enum TreatmentCategory: String, Codable, CaseIterable, Identifiable {
    case medicine = "Medicine"
    case natural = "Natural Remedies"
    case other = "Other"
    
    var id:String { rawValue }
}
