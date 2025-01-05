//
//  Trigger.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import Foundation
import SwiftData

@Model
final class Trigger:Identifiable, Hashable, GenericTriggerTreatmentSymptom {
    @Attribute(.unique) var id: UUID
    var title: String
    var icon: String?
    var category: TriggerCategory?
    @Relationship(inverse: \Entry.triggers) var entriesIn: [Entry] = []
    
    init(title: String?, icon: String?) {
        self.id = UUID()
        
        if let title = title {
            self.title = title
        } else {
            self.title = "Untitled Trigger"
        }
        
        self.icon = icon
        self.category = TriggerCategory.other
    }
    
    init(title: String, icon: String, category: TriggerCategory) {
        self.id = UUID()
        
        if title.isEmpty {
            self.title = "Untitled Trigger"
        } else {
            self.title = title
        }
        
        self.icon = icon
        self.category = category
    }
}

enum TriggerCategory: String, Codable, CaseIterable, Identifiable {
    case lifestyle = "Lifestyle"
    case environment = "Environment"
    case diet = "Diet"
    case other = "Other"
    
    var id:String { rawValue }
}
