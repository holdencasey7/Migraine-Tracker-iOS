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
    @Relationship(inverse: \Followup.ratings) var followup: Followup
    var ratingValue: Int
    
    init (treatment: Treatment, followup: Followup, ratingValue: Int) {
        self.id = UUID()
        self.treatment = treatment
        self.followup = followup
        self.ratingValue = ratingValue
        
        treatment.ratings.append(self)
        followup.ratings.append(self)
    }
}

//enum RatingOptions: String, Codable, CaseIterable, Identifiable {
//    case not = "Not Effective"
//    case mild = "Mildly Effective"
//    case very = "Very Effective"
//    case noRating = "No Rating"
//    
//    var id:String { rawValue }
//}
