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
    @Relationship(inverse: \Entry.followup) var entry: Entry
    @Relationship(deleteRule: .cascade) var ratings: [Rating] = []
    
    init (entry: Entry) {
        self.id = UUID()
        self.entry = entry
        
        entry.followup = self
    }
}
