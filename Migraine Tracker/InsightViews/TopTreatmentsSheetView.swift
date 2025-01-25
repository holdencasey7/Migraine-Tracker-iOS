//
//  TopTreatmentsSheetView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/23/25.
//

import SwiftUI

struct TopTreatmentsSheetView: View {
    var treatments: [Treatment]
    var body: some View {
        VStack {
            Text("HIGHEST RATED TREATMENTS")
                .font(Font.custom("Avenir", size: Constants.headerFontSize))
                .kerning(Constants.subtitleKerning)
                .minimumScaleFactor(0.9)
                .lineLimit(1)
                .allowsTightening(true)
                .padding()
            ScrollView {
                let treatmentsAndRatings: [(Treatment, Double)] = getHighestAverageRatedTreatments(treatments: treatments)
                ForEach(treatmentsAndRatings, id: \.0) { treatmentAndRating in
                    HStack {
                        GenericRowView(item: treatmentAndRating.0)
                        Spacer()
                        Text("\(String(format: "%.1f", treatmentAndRating.1))/3.0")
                            .font(Font.custom("Avenir", size: Constants.bodyFontSize))
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        .background(Color("Blue1"))
    }
    
    private func getHighestAverageRatedTreatments(treatments: [Treatment]) -> [(Treatment, Double)] {
        let sortedTreatments = treatments.compactMap { treatment in
            if let averageRating = treatment.averageRating {
                return (treatment, averageRating)
            }
            return nil
        }.sorted { $0.1 > $1.1 }
        
        return sortedTreatments
    }
}

//#Preview {
//    TopTreatmentsSheetView()
//}
