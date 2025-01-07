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
        VStack {
            ForEach(followup.ratings) { rating in
                HStack {
                    Text(rating.treatment.title)
                    HStack {
                        Image(systemName: rating.ratingValue == 0 ? "star" : "star.fill")
                        Image(systemName: rating.ratingValue <= 1 ? "star" : "star.fill")
                        Image(systemName: rating.ratingValue <= 2 ? "star" : "star.fill")
                    }
                }
            }
        }
    }
}

//#Preview {
//    FollowupDetailView()
//}
