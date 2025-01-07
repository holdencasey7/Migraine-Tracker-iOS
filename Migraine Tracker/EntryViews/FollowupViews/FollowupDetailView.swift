//
//  FollowupDetailView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct FollowupDetailView: View {
    @State var followup: Followup
    
    var body: some View {
        Text("Hello, World!")
//        ForEach(followup.entry.treatments) { treatment in
//            ForEach(treatment.ratings) { rating in
//                HStack {
//                    Text(treatment.title)
//                    HStack {
//                        Image(systemName: rating.ratingValue == 0 ? "star" : "star.fill")
//                        Image(systemName: rating.ratingValue <= 1 ? "star" : "star.fill")
//                        Image(systemName: rating.ratingValue <= 2 ? "star" : "star.fill")
//                    }
//                }
//            }
//        }
        // Need to add specific ratings in followup so that I dont get ALLLL ratings for each treatment
    }
}

//#Preview {
//    FollowupDetailView()
//}
