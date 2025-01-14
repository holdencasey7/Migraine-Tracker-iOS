//
//  RateTreatmentsView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct RateTreatmentsView: View {
    @Binding var treatmentRatings: [Treatment : Int]
    var body: some View {
        List {
            ForEach(Array(treatmentRatings.keys), id: \.self) { treatment in
                HStack(alignment: .center, spacing: 2) {
                    Text("\(treatment.title): ")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    HStack {
                        Image(systemName: treatmentRatings[treatment] ?? 0 == 0 ? "star" : "star.fill")
                            .font(.system(size: Constants.subtitleFontSize))
                            .onTapGesture {
                                if treatmentRatings[treatment] == 1 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 1
                                }
                            }
                        Image(systemName: treatmentRatings[treatment] ?? 0 <= 1 ? "star" : "star.fill")
                            .font(.system(size: Constants.subtitleFontSize))
                            .onTapGesture {
                                if treatmentRatings[treatment] == 2 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 2
                                }
                            }
                        Image(systemName: treatmentRatings[treatment] ?? 0 <= 2 ? "star" : "star.fill")
                            .font(.system(size: Constants.subtitleFontSize))
                            .onTapGesture {
                                if treatmentRatings[treatment] == 3 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 3
                                }
                            }
                    }
                    Spacer()
                    if let rating = treatmentRatings[treatment] {
                        if rating == 0 {
                            Text("Not rated")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        } else if rating == 1 {
                            Text("Not Effective")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        } else if rating == 2 {
                            Text("Moderately Effective")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        } else {
                            Text("Very Effective")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .scrollContentBackground(.hidden)
    }
}


//#Preview {
//    RateTreatmentsView()
//}
