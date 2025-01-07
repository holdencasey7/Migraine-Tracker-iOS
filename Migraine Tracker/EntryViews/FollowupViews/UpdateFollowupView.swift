//
//  UpdateFollowupView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/7/25.
//

import SwiftUI
import SwiftData

struct UpdateFollowupView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var entry: Entry
    @State var changedTreatmentRatings: [Treatment: Int] = [:]
    @State var newTreatmentRatings: [Treatment: Int] = [:]
    
    var body: some View {
        VStack{
            Text("Existing Ratings:")
            RateTreatmentsView(treatmentRatings: $changedTreatmentRatings)
            Text("New Ratings:")
            RateTreatmentsView(treatmentRatings: $newTreatmentRatings)
            Button(action: updateFollowup) {
                Text("Update Followup")
            }
        }
        .onAppear {
            let existingTreatmentsToRatings = getExistingRatings(entry: entry)
            let newRatingValues = getNewRatingValues(entry: entry, existingTreatmentsToRatings: existingTreatmentsToRatings)
            changedTreatmentRatings = existingTreatmentsToRatings
            newTreatmentRatings = newRatingValues
        }
    }
    
    private func getExistingRatings(entry: Entry) -> [Treatment : Int] {
        var existingTreatmentsToRatings: [Treatment : Int] = [:]
        if let followup = entry.followup {
            followup.ratings.forEach { rating in
                existingTreatmentsToRatings[rating.treatment] = rating.ratingValue
            }
        }
        return existingTreatmentsToRatings
    }
    
    private func getNewRatingValues(entry: Entry, existingTreatmentsToRatings: [Treatment : Int]) -> [Treatment : Int] {
        var newRatingValues: [Treatment : Int] = [:]
        entry.treatments.forEach { treatment in
            if existingTreatmentsToRatings[treatment] == nil { // if treatment not in keys
                newRatingValues[treatment] = 0
            }
        }
        return newRatingValues
    }
    
    private func updateFollowup() {
        newTreatmentRatings.forEach { treatment, ratingValue in
            let rating: Rating = .init(treatment: treatment, followup: entry.followup!, ratingValue: ratingValue)
            modelContext.insert(rating)
            try? modelContext.save()
        }
        
        changedTreatmentRatings.forEach { treatment, ratingValue in
            let rating: Rating = entry.followup!.ratings.first { $0.treatment == treatment }!
            rating.ratingValue = ratingValue
            modelContext.insert(rating)
            try? modelContext.save()
        }
    }
}

//#Preview {
//    UpdateFollowupView()
//}
