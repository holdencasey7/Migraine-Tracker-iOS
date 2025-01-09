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
        HStack(alignment: .top) {
            VStack {
                if let highestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments).0 {
                    Text("Top Treatment")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
//                        .padding(.bottom, -15)
                    Spacer()
                    if let imageName = highestAverageRatingTreatment.icon {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    Text("\(highestAverageRatingTreatment.title)")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)

                }
            }
            .padding(.horizontal)
            VStack {
                if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers).0 {
                    Text("Top Trigger")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
//                        .padding(.bottom, -15)
                    Spacer()
                    if let imageName = mostCommonTrigger.icon {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    Text("\(mostCommonTrigger.title)")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
        }
        
//        VStack {
//            
//            if let highestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments).0 {
//                if let averageRatingOfHighestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments).1 {
//                    Text("Leading Treatment: \(highestAverageRatingTreatment.title) (\(String(format: "%.1f", averageRatingOfHighestAverageRatingTreatment))/3)")
//                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//                        .multilineTextAlignment(.center)
//                } else {
//                    Text("Leading Treatment: \(highestAverageRatingTreatment.title)")
//                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//                        .multilineTextAlignment(.center)
//                }
//            } else {
//                Text("No Rated Treatments Found")
//                    .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//            }
//            
//            
//            if let countOfMostCommonTrigger = getMostCommonTrigger(triggers: triggers).1 {
//                if countOfMostCommonTrigger > 0 {
//                    if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers).0 {
//                        Text("Leading Trigger: \(mostCommonTrigger.title) (\(countOfMostCommonTrigger)x)")
//                            .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//                            .multilineTextAlignment(.center)
//                    }
//                } else {
//                    Text("No Triggers Logged")
//                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//                }
//            } else {
//                Text("No Triggers Logged")
//                    .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
//            }
//        }
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
}

//#Preview {
//    LeadingTriggerAndTreatmentView()
//}
