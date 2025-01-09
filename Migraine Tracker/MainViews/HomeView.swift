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
        ZStack {
            Image("HomeViewBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Covers entire screen
            
            VStack {
                Spacer()
                FrequencyLineChartView(entries: entries)
                    .frame(maxHeight: 400)
                    .padding(.horizontal)
                    .padding(.top, 20)
                Spacer()
                LeadingTriggerAndTreatmentView(triggers: triggers, treatments: treatments)
                    .padding(.top)
                    .padding(.horizontal)
                Spacer()
                GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
                    .padding()
                    .padding(.bottom, 50)
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView(contentViewSelection: .constant(0))
}
