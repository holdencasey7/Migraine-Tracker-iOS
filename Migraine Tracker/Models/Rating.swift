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
    var rating: Int
    
    init (treatment: Treatment, rating: Int) {
        self.id = UUID()
        self.treatment = treatment
        self.rating = rating
        
        treatment.ratings.append(self)
    }
}
