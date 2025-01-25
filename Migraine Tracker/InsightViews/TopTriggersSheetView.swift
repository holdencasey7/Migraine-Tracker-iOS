//
//  TopTriggersSheetView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/23/25.
//

import SwiftUI

struct TopTriggersSheetView: View {
    var triggers: [Trigger]
    var body: some View {
        VStack {
            Text("MOST COMMON TRIGGERS")
                .font(Font.custom("Avenir", size: Constants.headerFontSize))
                .kerning(Constants.subtitleKerning)
                .minimumScaleFactor(0.9)
                .lineLimit(1)
                .allowsTightening(true)
                .padding()
            ScrollView {
                let triggerAndCounts: [(Trigger, Int)] = getMostCommonTriggers(triggers: triggers)
                ForEach(triggerAndCounts, id: \.0) { triggerAndCount in
                    HStack {
                        GenericRowView(item: triggerAndCount.0)
                        Spacer()
                        Text("\(triggerAndCount.1)x")
                            .font(Font.custom("Avenir", size: Constants.bodyFontSize))
                            .lineLimit(1)
                            .allowsTightening(true)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        .background(Color("Blue1"))
    }
    
    private func getMostCommonTriggers(triggers: [Trigger]) -> [(Trigger, Int)] {
        let sortedTriggers = triggers.compactMap { trigger in
            (trigger, trigger.entriesIn.count)
        }.sorted { $0.1 > $1.1 }
        .filter { $0.1 > 0 }
        
        return sortedTriggers
    }
}

//#Preview {
//    TopTriggersSheetView()
//}
