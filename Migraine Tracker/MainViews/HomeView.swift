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
    
    @State private var localTriggers: [Trigger] = []
    @State private var localTreatments: [Treatment] = []
    
    @State var presentManageTriggerSheet: Bool = false
    @State var presentManageTreatmentSheet: Bool = false
    @Binding var contentViewSelection: Int

    var body: some View {
        ZStack {
            Image("HomeViewBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    // Use task modifier to update local state asynchronously when the view first appears
                    LeadingTriggerAndTreatmentView(triggers: localTriggers, treatments: localTreatments)
                        .padding()
                        .frame(height: geometry.size.height * 0.2)
                        .task {
                            // Update localTriggers and localTreatments asynchronously
//                            if localTriggers.isEmpty && localTreatments.isEmpty {
                                localTriggers = Array(triggers)
                                localTreatments = Array(treatments)
//                            }
                        }
                    Spacer()
                    FrequencyLineChartView(entries: Array(entries))
                        .padding()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                    Spacer()
                    GiantAddEntryButtonView(contentViewSelection: $contentViewSelection)
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}






#Preview {
    HomeView(contentViewSelection: .constant(0))
}
