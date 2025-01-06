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
    @Relationship(inverse: \Treatment.ratings) var treatment: Treatment
    var ratingValue: Int
    
    init (treatment: Treatment, ratingValue: Int) {
        self.id = UUID()
        self.treatment = treatment
        self.ratingValue = ratingValue
        
        treatment.ratings.append(self)
    }
}
