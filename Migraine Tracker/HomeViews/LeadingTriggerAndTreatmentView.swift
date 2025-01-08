//
//  LeadingTriggerAndTreatmentView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/6/25.
//

import SwiftUI

struct LeadingTriggerAndTreatmentView: View {
    @State var triggers: [Trigger]
    @State var treatments: [Treatment]
    
    var body: some View {
        VStack {
            if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers).0 {
                if let countOfMostCommonTrigger = getMostCommonTrigger(triggers: triggers).1 {
                    Text("Most Common Trigger: \(mostCommonTrigger.title) (\(countOfMostCommonTrigger) entries)")
                } else {
                    Text("Most Common Trigger: \(mostCommonTrigger.title)")
                }
            } else {
                Text("No Triggers Found")
            }
            
            if let highestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments).0 {
                if let averageRatingOfHighestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments).1 {
                    Text("Highest Average Rating Treatment: \(highestAverageRatingTreatment.title) (\(averageRatingOfHighestAverageRatingTreatment))")
                } else {
                    Text("Highest Average Rating Treatment: \(highestAverageRatingTreatment.title)")
                }
            } else {
                Text("No Rated Treatments Found")
            }
        }
    }
    
    private func getMostCommonTrigger(triggers: [Trigger]) -> (Trigger?, Int?) {
        var triggerDictionary: [Trigger: Int] = [:]
        triggers.forEach { trigger in
            triggerDictionary[trigger, default: 0] = trigger.entriesIn.count
        }
        let sortedTriggerDictionary = triggerDictionary.sorted { $0.value > $1.value }
        return (sortedTriggerDictionary.first?.key, sortedTriggerDictionary.first?.value)
    }
    
    private func getHighestAverageRatedTreatment(treatments: [Treatment]) -> (Treatment?, Double?) {
        var highestAverageRating: Double?
        var highestAverageRatingTreatment: Treatment?
        treatments.forEach { treatment in
            if let averageRating = treatment.averageRating {
                if highestAverageRating == nil || averageRating > highestAverageRating! {
                    highestAverageRating = averageRating
                    highestAverageRatingTreatment = treatment
                }
            }
        }
        return (highestAverageRatingTreatment, highestAverageRating)
    }
    
//    private func getMostEffectiveTreatment(treatments: [Treatment]) -> Treatment? {
//        var treatmentDictionary: [Treatment: Double] = [:]
//        treatments.forEach { treatment in
//            var treatmentRating = 0.0
//            treatment.ratings.forEach { rating in
//                treatmentRating += Double(rating.ratingValue)
//            }
//            if treatment.ratings.count > 0 {
//                treatmentRating /= Double(treatment.ratings.count)
//            }
//            treatmentDictionary[treatment, default: 0.0] = treatmentRating
//        }
//        let sortedTreatmentDictionary = treatmentDictionary.sorted { $0.value > $1.value }
//        return sortedTreatmentDictionary.first?.key
//    }
}

//#Preview {
//    LeadingTriggerAndTreatmentView()
//}
