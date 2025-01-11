//
//  FollowupView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI
import SwiftData

struct CreateFollowupView: View {
    @Binding var entry: Entry
    @Environment(\.modelContext) private var modelContext
    
    @State var newIntensity: Int = 1
    @State var newSymptoms: [Symptom] = []
    @State var newTreatments: [Treatment] = []
    @State var treatmentRatings: [Treatment: Int] = [:]
    @State var endDate: Date = Date()
    
    var body: some View {
        VStack {
            RateTreatmentsView(treatmentRatings: $treatmentRatings)
            HStack {
                Text("End Date:")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    .padding()
                DatePicker("", selection: $endDate)
                    .padding(.trailing, 50)
            }
            Button(action: addFollowup) {
                Text("Add Followup")
            }
        }
        .onAppear {
            entry.treatments.forEach { treatment in
                treatmentRatings[treatment] = 0
            }
        }
    }
    
    private func addFollowup() {
        let followup: Followup = .init(entry: entry, endDate: endDate)
        do {
            try modelContext.transaction {
                modelContext.insert(followup)
                treatmentRatings.forEach { treatment, ratingValue in
                    let rating: Rating = .init(treatment: treatment, followup: followup, ratingValue: ratingValue)
                    modelContext.insert(rating)
                }
                do {
                    try modelContext.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        
        
    }
}

//#Preview {
//    CreateFollowupView()
//}
