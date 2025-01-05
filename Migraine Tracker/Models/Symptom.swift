//
//  Symptom.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import Foundation
import SwiftData

@Model
final class Symptom:Identifiable, Hashable, GenericTriggerTreatmentSymptom{
    @Attribute(.unique) var id: UUID
    var title: String
    var icon: String?
    @Relationship(inverse: \Entry.symptoms) var entriesIn: [Entry] = []
    @Relationship(deleteRule: .cascade) var ratings: [Rating] = []
    
    init(title: String?, icon: String?) {
        self.id = UUID()
        
        if let title = title {
            self.title = title
        } else {
            self.title = "Untitled Symptom"
        }
        
        self.icon = icon
    }
}
