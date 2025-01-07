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
                HStack {
                    Text(treatment.title)
                    HStack {
                        Image(systemName: treatmentRatings[treatment] ?? 0 == 0 ? "star" : "star.fill")
                            .onTapGesture {
                                if treatmentRatings[treatment] == 1 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 1
                                }
                            }
                        Image(systemName: treatmentRatings[treatment] ?? 0 <= 1 ? "star" : "star.fill")
                            .onTapGesture {
                                if treatmentRatings[treatment] == 2 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 2
                                }
                            }
                        Image(systemName: treatmentRatings[treatment] ?? 0 <= 2 ? "star" : "star.fill")
                            .onTapGesture {
                                if treatmentRatings[treatment] == 3 {
                                    treatmentRatings[treatment] = 0
                                } else {
                                    treatmentRatings[treatment] = 3
                                }
                            }
                    }
                }
            }
        }
    }
}

//#Preview {
//    RateTreatmentsView()
//}
