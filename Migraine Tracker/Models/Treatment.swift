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
