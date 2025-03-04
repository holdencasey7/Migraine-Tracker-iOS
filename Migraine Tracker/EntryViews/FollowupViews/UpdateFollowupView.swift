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
    var followup: Followup
    @State var changedTreatmentRatings: [Treatment: Int] = [:]
    @State var newTreatmentRatings: [Treatment: Int] = [:]
    @State var newEndDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
            if !changedTreatmentRatings.isEmpty {
                Text("Existing Ratings:")
                    .font(Font.custom("Avenir", size: Constants.headerFontSize))
                    .padding()
                RateTreatmentsView(treatmentRatings: $changedTreatmentRatings)
                    .padding(.horizontal)
            }
            if !newTreatmentRatings.isEmpty {
                Text("New Ratings:")
                    .font(Font.custom("Avenir", size: Constants.headerFontSize))
                    .padding()
                RateTreatmentsView(treatmentRatings: $newTreatmentRatings)
                    .padding(.horizontal)
            }
            HStack {
                Text("End Date:")
                    .font(Font.custom("Avenir", size: Constants.headerFontSize))
                    .padding()
                DatePicker("", selection: $newEndDate)
                    .padding(.trailing, 50)
            }
            .padding()
            Button(action: updateFollowup) {
                Text("Update Follow-Up")
            }
            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
            .kerning(Constants.subtitleKerning)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .allowsTightening(true)
            .padding(5)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: Constants.entryDetailViewButtonRoundedRectangleCornerRadius)
                    .fill(Color("MediumPink").opacity(Constants.entryDetailViewButtonRoundedRectangleOpacity))
            )
        }
        .background(Color("FirstLightPink"))
        .onAppear {
            if let entry = followup.entry {
                let existingTreatmentsToRatings = getExistingRatings(entry: entry)
                let newRatingValues = getNewRatingValues(entry: entry, existingTreatmentsToRatings: existingTreatmentsToRatings)
                changedTreatmentRatings = existingTreatmentsToRatings
                newTreatmentRatings = newRatingValues
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
        do {
            try modelContext.transaction {
                newTreatmentRatings.forEach { treatment, ratingValue in
                    let rating: Rating = .init(treatment: treatment, followup: followup, ratingValue: ratingValue)
                    modelContext.insert(rating)
                }
                changedTreatmentRatings.forEach { treatment, ratingValue in
                    let rating: Rating = followup.ratings.first { $0.treatment == treatment }!
                    rating.ratingValue = ratingValue
                    modelContext.insert(rating)
                }
                
                followup.endDate = newEndDate
                modelContext.insert(followup)
                do {
                    try modelContext.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        isPresented = false
    }
}


//#Preview {
//    UpdateFollowupView()
//}
