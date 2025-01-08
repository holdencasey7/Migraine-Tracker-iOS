//
//  RatingView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/7/25.
//

import SwiftUI

struct RatingRowView: View {
    var rating: Rating
    var body: some View {
        HStack {
            if let treatment = rating.treatment {
                Text(treatment.title)
                HStack {
                    Image(systemName: rating.ratingValue == 0 ? "star" : "star.fill")
                    Image(systemName: rating.ratingValue <= 1 ? "star" : "star.fill")
                    Image(systemName: rating.ratingValue <= 2 ? "star" : "star.fill")
                }
            }
        }
    }
}

//#Preview {
//    RatingView()
//}
