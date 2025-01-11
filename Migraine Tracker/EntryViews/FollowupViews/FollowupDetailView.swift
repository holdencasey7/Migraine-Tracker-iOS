//
//  FollowupDetailView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct FollowupDetailView: View {
    @State var followup: Followup
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy 'at' hh:mm a"
        return formatter
    }()
    @State var presentUpdateFollowupSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color("MediumPink").edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    Text("FOLLOW-UP")
                        .font(Font.custom("Avenir", size: Constants.headerFontSize))
                        .kerning(Constants.subtitleKerning)
                        .padding()
                        .padding(.top, 30)
                    Spacer()
                    ScrollView {
                        VStack {
                            ForEach(followup.ratings) { rating in
                                RatingRowView(rating: rating)
                                    .padding(5)
                            }
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.9, height: min(CGFloat(followup.ratings.count * 60), 250))
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        if let entry = followup.entry {
                            Text("Start Date: \(entry.timestamp, formatter: dateFormatter)")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .kerning(1)
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                                .allowsTightening(true)
                            Text("End Date: \(followup.endDate, formatter: dateFormatter)")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .kerning(1)
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
                                .allowsTightening(true)
                            if let duration = entry.duration {
                                let hours = Int(duration) / 3600
                                let minutes = (Int(duration) % 3600) / 60
                                Text("Duration: \(hours)h \(minutes)m")
                                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                    .kerning(1)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                            } else {
                                Text("Duration: N/A")
                                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                    .kerning(1)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                            }
                        }
                    }
                    .padding()
                    .padding(.vertical)
                    .frame(width: geometry.size.width * 0.9)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    
                    
                    Spacer()
                    
                    Button(action: {
                        presentUpdateFollowupSheet = true
                    }) {
                        Text("EDIT FOLLOW-UP")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .padding()
                    }
                    .sheet(isPresented: $presentUpdateFollowupSheet) {
                        UpdateFollowupView(followup: followup, newEndDate: followup.endDate, isPresented: $presentUpdateFollowupSheet)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    .padding()
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
            }
        }
    }
}

//#Preview {
//    @Previewable var followup: Followup? = nil
//    FollowupDetailView(followup: .init(entry: Entry(
//        timestamp: Date(),
//        intensity: 5,
//        triggers: [],
//        symptoms: [],
//        treatments: [],
//        notes: "Initial migraine entry for testing purposes"
//    ), endDate: Date()))
//        
//}
