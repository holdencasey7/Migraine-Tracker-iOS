import SwiftUI

struct LeadingTriggerAndTreatmentView: View {
    var triggers: [Trigger]
    var treatments: [Treatment]
    
    @State var showTopTriggersSheet: Bool = false
    @State var showTopTreatmentsSheet: Bool = false
    
    var body: some View {
            HStack(alignment: .top) {
                VStack {
                    if let highestAverageRatingTreatment = getHighestAverageRatedTreatment(treatments: treatments)?.treatment {
                        Text("Top Treatments")
                            .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.8)
                            .lineLimit(2)
                            .allowsTightening(true)
                            .underline(true)
                            .onTapGesture {showTopTreatmentsSheet = true}
                            .sheet(isPresented: $showTopTreatmentsSheet) {
                                TopTreatmentsSheetView(treatments: treatments)
                            }
                        
                        if let imageName = highestAverageRatingTreatment.icon {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 80)
                                .padding(.vertical, -5)
                        }
                        Text(highestAverageRatingTreatment.title)
                            .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.8)
                            .lineLimit(2)
                            .allowsTightening(true)
                    } else {
                        Text("No rated treatments!")
                            .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.8)
                            .lineLimit(2)
                            .allowsTightening(true)
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    if let mostCommonTrigger = getMostCommonTrigger(triggers: triggers)?.trigger {
                        if getMostCommonTrigger(triggers: triggers)!.count > 0 {
                            Text("Top Triggers")
                                .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.8)
                                .lineLimit(2)
                                .allowsTightening(true)
                                .underline(true)
                                .onTapGesture {showTopTriggersSheet = true}
                                .sheet(isPresented: $showTopTriggersSheet) {
                                    TopTriggersSheetView(triggers: triggers)
                                }
                            if let imageName = mostCommonTrigger.icon {
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 80)
                                    .padding(.vertical, -5)
                            }
                            Text(mostCommonTrigger.title)
                                .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.8)
                                .lineLimit(2)
                                .allowsTightening(true)
                        } else {
                            Text("No triggers recorded!")
                                .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.8)
                                .lineLimit(2)
                                .allowsTightening(true)
                        }
                    } else {
                        Text("No triggers recorded!")
                            .font(Font.custom("Avenir", size: Constants.leadingTriggerTreatmentFontSize))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.8)
                            .lineLimit(2)
                            .allowsTightening(true)
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
