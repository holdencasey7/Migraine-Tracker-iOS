//
//  FollowupCompletionIconView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/10/25.
//

import SwiftUI

struct FollowupCompletionIconView: View {
    var entry: Entry
    
    var body: some View {
        let followupCompletion = pickFollowupView(entry: entry)
        switch followupCompletion {
        case 0:
            Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                .font(.title)
                .foregroundColor(Color("Blue5"))
        case 1:
            Image(systemName: "checkmark.circle.trianglebadge.exclamationmark")
                .font(.title)
                .foregroundColor(Color("Blue2"))
        case 2:
            Text("")
                .font(.title)
        default:
            Text("")
                .font(.title)
        }
    }
    
    private func pickFollowupView(entry: Entry) -> Int {
        if let followup = entry.followup {
            var hasNewTreatment = false
            var existingRatedTreatments: [Treatment] = []
            followup.ratings.forEach { rating in
                existingRatedTreatments.append(rating.treatment ?? .init(title: "Error Treatment", icon: "", category: .other))
            }
            entry.treatments.forEach { treatment in
                if !existingRatedTreatments.contains(treatment) {
                    hasNewTreatment = true
                }
            }
            if hasNewTreatment {
                return 1
            } else {
                return 0
            }
        } else {
            return 2
        }
    }
}

//#Preview {
//    FollowupCompletionIconView()
//}
