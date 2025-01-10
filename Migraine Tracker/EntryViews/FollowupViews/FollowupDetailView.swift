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
        formatter.dateFormat = "MM/dd/yy 'at' hh:mm a"
        return formatter
    }()
    @State var presentUpdateFollowupSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color("MediumPink").edgesIgnoringSafeArea(.all)
            
            if let followup = followup {
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
                    .frame(width: 350, height: min(CGFloat(followup.ratings.count * 60), 250))
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    .padding(0) // Ensure no extra padding added here
                    Spacer()
                    VStack {
                        if let entry = followup.entry {
                            Text("Start Date: \(entry.timestamp, formatter: dateFormatter)")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .padding(.horizontal)
                                .padding(.top)
                            Text("End Date: \(followup.endDate, formatter: dateFormatter)")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            if let duration = entry.duration {
                                let hours = Int(duration) / 3600
                                let minutes = (Int(duration) % 3600) / 60
                                Text("Duration: \(hours)h \(minutes)m")
                                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            } else {
                                Text("Duration: N/A")
                                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 350)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )

                    
                    Spacer()
                    
                    Button(action: {
                        presentUpdateFollowupSheet = true
                    }) {
                        Text("UPDATE FOLLOW-UP")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .padding()
                    }
                    .sheet(isPresented: $presentUpdateFollowupSheet) {
                        UpdateFollowupView(followup: $followup, newEndDate: followup.endDate, isPresented: $presentUpdateFollowupSheet)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.5))
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    .padding()
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

//#Preview {
//    FollowupDetailView()
//}
