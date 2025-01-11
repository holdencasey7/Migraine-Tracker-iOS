import SwiftUI

struct LeadingTriggerAndTreatmentView: View {
    var triggers: [Trigger]
    var treatments: [Treatment]
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                if let highestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments)?.treatment {
                    Text("Top Treatment")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                    
                    if let imageName = highestAverageRatingTreatment.icon {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    Text(highestAverageRatingTreatment.title)
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
            
            VStack {
                if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers)?.trigger {
                    Text("Top Trigger")
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)

                    if let imageName = mostCommonTrigger.icon {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    Text(mostCommonTrigger.title)
                        .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func getMostCommonTrigger(triggers: [Trigger]) -> (trigger: Trigger, count: Int)? {
        let sortedTriggers = triggers.compactMap { trigger in
            (trigger, trigger.entriesIn.count)
        }.sorted { $0.1 > $1.1 }
        
        return sortedTriggers.first
    }
    
    private func getHighestAverageRatedTreatment(treatments: [Treatment]) -> (treatment: Treatment, rating: Double)? {
        let sortedTreatments = treatments.compactMap { treatment in
            if let averageRating = treatment.averageRating {
                return (treatment, averageRating)
            }
            return nil
        }.sorted { $0.1 > $1.1 }
        
        return sortedTreatments.first
    }
}
