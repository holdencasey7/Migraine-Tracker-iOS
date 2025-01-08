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
    @Relationship(deleteRule: .nullify, inverse: \Treatment.ratings) var treatment: Treatment?
    @Relationship(deleteRule: .nullify, inverse: \Followup.ratings) var followup: Followup?
    var ratingValue: Int
    
    init (treatment: Treatment, followup: Followup, ratingValue: Int) {
        self.id = UUID()
        self.treatment = treatment
        self.followup = followup
        if ratingValue < 0 {
            self.ratingValue = 0
        } else if ratingValue > 3 {
            self.ratingValue = 3
        } else {
            self.ratingValue = ratingValue
        }
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
