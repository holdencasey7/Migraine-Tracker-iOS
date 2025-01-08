//
//  FollowupDetailView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct FollowupDetailView: View {
    @State var followup: Followup?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    @State var presentUpdateFollowupSheet: Bool = false
    
    var body: some View {
        // Should add update option if they want to change the ratings
        if let followup = followup {
            VStack {
                ForEach(followup.ratings) { rating in
                    RatingRowView(rating: rating)
                }
                VStack {
                    if let entry = followup.entry {
                        Text("Start Date: \(entry.timestamp, formatter: dateFormatter)")
                        Text("End Date: \(followup.endDate, formatter: dateFormatter)")
                        if let duration = entry.duration {
                            let hours = Int(duration) / 3600
                            let minutes = (Int(duration) % 3600) / 60
                            Text("Duration: \(hours)h \(minutes)m")
                        } else {
                            Text("Duration: N/A")
                        }
                    }
                }
                // Update Followup Button
                Button(action: {
                    presentUpdateFollowupSheet = true
                }) {
                    Text("Update Followup")
                }
                .sheet(isPresented: $presentUpdateFollowupSheet) {
                    UpdateFollowupView(followup: $followup, newEndDate: followup.endDate, isPresented: $presentUpdateFollowupSheet)
                }
            }
        }
    }
}

//#Preview {
//    FollowupDetailView()
//}
