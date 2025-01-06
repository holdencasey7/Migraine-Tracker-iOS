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
            if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers) {
                Text("Most Common Trigger: \(mostCommonTrigger)")
            } else {
                Text("No Triggers Found")
            }
            
            if let mostEffectiveTreatment = getMostEffectiveTreatment(treatments: treatments) {
                Text("Most Effective Treatment: \(mostEffectiveTreatment)")
            } else {
                Text("No Treatment Ratings Found")
            }
        }
    }
    
    private func getMostCommonTrigger(triggers: [Trigger]) -> Trigger? {
        var triggerDictionary: [Trigger: Int] = [:]
        triggers.forEach { trigger in
            triggerDictionary[trigger, default: 0] = trigger.entriesIn.count
        }
        let sortedTriggerDictionary = triggerDictionary.sorted { $0.value > $1.value }
        return sortedTriggerDictionary.first?.key
    }
    
    private func getMostEffectiveTreatment(treatments: [Treatment]) -> Treatment? {
        var treatmentDictionary: [Treatment: Double] = [:]
        treatments.forEach { treatment in
            var treatmentRating = 0.0
            treatment.ratings.forEach { rating in
                treatmentRating += Double(rating.ratingValue)
            }
            if treatment.ratings.count > 0 {
                treatmentRating /= Double(treatment.ratings.count)
            }
            treatmentDictionary[treatment, default: 0.0] = treatmentRating
        }
        let sortedTreatmentDictionary = treatmentDictionary.sorted { $0.value > $1.value }
        return sortedTreatmentDictionary.first?.key
    }
}

//#Preview {
//    LeadingTriggerAndTreatmentView()
//}
