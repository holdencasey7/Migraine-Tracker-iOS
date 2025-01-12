//
//  InsightsView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/30/24.
//

import SwiftUI
import SwiftData

struct InsightsView: View {
    @Query var entries: [Entry]
    @Query var triggers: [Trigger]
    @Query var treatments: [Treatment]
    
    @State var localEntries: [Entry] = []
    @State var localTriggers: [Trigger] = []
    @State var localTreatments: [Treatment] = []
    
    var body: some View {
        GeometryReader { geometry in
            if localEntries.count < Constants.minimumRequiredEntryCount {
                VStack {
                    Text("Please enter at least \(Constants.minimumRequiredEntryCount) entries")
                    Text("You currently have \(localEntries.count) entries")
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack {
                        LeadingTriggerAndTreatmentView(triggers: localTriggers, treatments: localTreatments)
                            .task {
                                localTriggers = Array(triggers)
                                localTreatments = Array(treatments)
                            }
                            .padding(.vertical)
                        AverageDurationView(entries: localEntries)
                            .padding(.vertical)
                        FrequencyLineChartView(entries: localEntries)
                            .padding(.vertical)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                        AverageWeatherView(entries: localEntries)
                            .padding(.vertical)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .task {
            localEntries = Array(entries)
        }
    }
}

#Preview {
    InsightsView()
}
