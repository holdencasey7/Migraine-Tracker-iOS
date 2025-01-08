//
//  HomeView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var triggers: [Trigger]
    @Query var treatments: [Treatment]
    @Query var symptoms: [Symptom]
    @Query var entries: [Entry]
    
    @State var presentManageTriggerSheet: Bool = false
    @State var presentManageTreatmentSheet: Bool = false
    @Binding var contentViewSelection: Int
    
    var body: some View {
        VStack {
            FrequencyLineChartView(entries: entries)
            Spacer()
            LeadingTriggerAndTreatmentView(triggers: triggers, treatments: treatments)
            Spacer()
            GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
        }
    }
}

#Preview {
    HomeView(contentViewSelection: .constant(0))
}
