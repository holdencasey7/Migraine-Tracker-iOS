//
//  AllTypesFollowupView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/7/25.
//

import SwiftUI

struct AllTypesFollowupView: View {
    @Binding var entry: Entry
    @Binding var isPresented: Bool
    @State var followup: Followup?
    var body: some View {
        let pickView = pickFollowupView(entry: entry)
        switch pickView {
        case 0:
            if let followup = entry.followup {
                FollowupDetailView(followup: followup)
            }
            
        case 1:
            if let followup = entry.followup {
                UpdateFollowupView(followup: $followup, newEndDate: followup.endDate, isPresented: .constant(true))
            }
        case 2:
            CreateFollowupView(entry: $entry)
        default:
            Text("How did I get here?")
        }
        
        // Done button?
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
//    AllTypesFollowupView()
//}
