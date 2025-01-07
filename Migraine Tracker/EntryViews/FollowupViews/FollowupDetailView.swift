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
        // Should add update option if they want to change the ratings
        VStack {
            ForEach(followup.ratings) { rating in
                RatingView(rating: rating)
            }
        }
    }
}

//#Preview {
//    FollowupDetailView()
//}
