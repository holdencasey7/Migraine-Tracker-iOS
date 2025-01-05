//
//  Rating.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import Foundation
import SwiftData

@Model
final class Rating:Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \Symptom.ratings) var symptom: Symptom
    var rating: Int
    
    init (symptom: Symptom, rating: Int) {
        self.id = UUID()
        self.symptom = symptom
        self.rating = rating
        
        symptom.ratings.append(self)
    }
}
