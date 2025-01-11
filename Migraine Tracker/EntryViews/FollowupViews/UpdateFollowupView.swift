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
    @Binding var followup: Followup?
    @State var changedTreatmentRatings: [Treatment: Int] = [:]
    @State var newTreatmentRatings: [Treatment: Int] = [:]
    @State var newEndDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
            HStack {
                Text("End Date:")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    .padding()
                DatePicker("", selection: $newEndDate)
                    .padding(.trailing, 50)
            }
            if !changedTreatmentRatings.isEmpty {
                Text("Existing Ratings:")
                RateTreatmentsView(treatmentRatings: $changedTreatmentRatings)
            }
            if !newTreatmentRatings.isEmpty {
                Text("New Ratings:")
                RateTreatmentsView(treatmentRatings: $newTreatmentRatings)
            }
            Button(action: updateFollowup) {
                Text("Update Followup")
            }
        }
        .onAppear {
            if let followup = followup {
                if let entry = followup.entry {
                    let existingTreatmentsToRatings = getExistingRatings(entry: entry)
                    let newRatingValues = getNewRatingValues(entry: entry, existingTreatmentsToRatings: existingTreatmentsToRatings)
                    changedTreatmentRatings = existingTreatmentsToRatings
                    newTreatmentRatings = newRatingValues
                }
            }
        }
    }
    
    private func getExistingRatings(entry: Entry) -> [Treatment : Int] {
        var existingTreatmentsToRatings: [Treatment : Int] = [:]
        if let followup = entry.followup {
            followup.ratings.forEach { rating in
                existingTreatmentsToRatings[rating.treatment ?? .init(title: "Error Treatment", icon: "", category: .other)] = rating.ratingValue
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
        if let followup = followup {
            newTreatmentRatings.forEach { treatment, ratingValue in
                let rating: Rating = .init(treatment: treatment, followup: followup, ratingValue: ratingValue)
                modelContext.insert(rating)
                try? modelContext.save()
            }
            changedTreatmentRatings.forEach { treatment, ratingValue in
                let rating: Rating = followup.ratings.first { $0.treatment == treatment }!
                rating.ratingValue = ratingValue
                modelContext.insert(rating)
                try? modelContext.save()
            }
            
            followup.endDate = newEndDate
            modelContext.insert(followup)
            try? modelContext.save()
        }
        isPresented = false
    }
}


//#Preview {
//    UpdateFollowupView()
//}
