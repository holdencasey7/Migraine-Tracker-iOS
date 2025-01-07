//
//  Followup.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import Foundation
import SwiftData

@Model
final class Followup:Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .nullify, inverse: \Entry.followup) var entry: Entry?
    @Relationship(deleteRule: .cascade) var ratings: [Rating] = []
    var endDate: Date
    
    init (entry: Entry, endDate: Date) {
        self.id = UUID()
        self.entry = entry
        self.endDate = endDate
        
        entry.followup = self
    }
}
