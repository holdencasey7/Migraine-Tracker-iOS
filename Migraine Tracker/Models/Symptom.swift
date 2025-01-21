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
    @Relationship(deleteRule: .nullify, inverse: \Entry.symptoms) var entriesIn: [Entry] = []
    
    init(title: String?, icon: String?) {
        self.id = UUID()
        
        if let title = title {
            self.title = title
        } else {
            self.title = "Untitled Symptom"
        }
        
        if let icon = icon {
            self.icon = icon
        } else {
            self.icon = "DefaultTriggerIcon"
        }
    }
}
