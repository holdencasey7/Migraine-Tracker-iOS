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
    
    @State private var refreshView: Bool = false
    
    var body: some View {
        ZStack {
            Image("HomeViewBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Covers entire screen
            
            VStack {
                Spacer()
                LeadingTriggerAndTreatmentView(triggers: triggers, treatments: treatments)
                    .padding(.horizontal)
                    .frame(height: 150)
                    .padding(.top, 50)
                Spacer()
                FrequencyLineChartView(entries: entries)
                    .padding(.horizontal)
                    .frame(height: 300)
                Spacer()
                GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
                    .padding()
                    .padding(.bottom, 50)
                Spacer()
            }
        }
        .onAppear {
            refreshView.toggle()
        }
    }
}

#Preview {
    HomeView(contentViewSelection: .constant(0))
}
