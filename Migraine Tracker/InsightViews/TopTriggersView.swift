//
//  TopTriggersView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI
import SwiftData

struct TopTriggersView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]
    @Query private var triggers: [Trigger]
    
    var body: some View {
        Text("Top Triggers")
            .font(.headline)
            .padding()
        VStack(alignment: .leading) {
            let topFiveTriggers = getTopFiveTriggers()
            ScrollView() {
                ForEach(topFiveTriggers, id: \.key) { trigger, count in
                    Text("\(trigger.title): \(count)")
                }
            }
        }
    }
    
    private func getTopFiveTriggers() -> Array<Dictionary<Trigger, Int>.Element>.SubSequence {
        var triggerDictionary: [Trigger: Int] = [:]
        entries.forEach { entry in
            @State var currEntry: Entry = entry
            currEntry.triggers.forEach { trigger in
                @State var currTrigger: Trigger = trigger
                triggerDictionary[currTrigger, default: 0] += 1
            }
        }
        let sortedTriggerDictionary = triggerDictionary.sorted { $0.value > $1.value }
        let topFiveTriggers = sortedTriggerDictionary.prefix(5)
        
        return topFiveTriggers
    }
}

#Preview {
    TopTriggersView()
}
