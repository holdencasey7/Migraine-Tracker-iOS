//
//  TreatmentNote.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/8/25.
//

import Foundation
import SwiftData

@Model
final class TreatmentNote: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .nullify, inverse: \Treatment.treatmentNotes) var treatmentIn: Treatment?
    @Relationship(deleteRule: .nullify, inverse: \Entry.treatmentNotes) var entryIn: Entry?
    
    init() {
        self.id = UUID()
    }
}
