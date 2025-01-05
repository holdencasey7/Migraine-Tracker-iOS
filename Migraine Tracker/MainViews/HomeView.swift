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
    
    @State var presentManageTriggerSheet: Bool = false
    @State var presentManageTreatmentSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("Home View")
//            WeatherView()
            Spacer()
            HStack {
                VStack {
                    Text("My Triggers")
                        .font(.headline)
//                    TriggerListView(triggers: triggers)
                    Button("Manage Triggers") {
                        presentManageTriggerSheet = true
                    }
                    .font(.title2)
                    .padding(5)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                    .background(Color("LightGrey"), in: RoundedRectangle(cornerRadius: 10))
                    .sheet(isPresented: $presentManageTriggerSheet) {
                        TriggerEditableMenuView(isPresented: $presentManageTriggerSheet)
                    }
                }
                VStack {
                    Text("My Treatments")
                        .font(.headline)
//                    TreatmentListView(treatments: treatments)
                    Button("Manage Treatments") {
                        presentManageTreatmentSheet = true
                    }
                    .font(.title2)
                    .padding(5)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                    .background(Color("LightGrey"), in: RoundedRectangle(cornerRadius: 10))
                    .sheet(isPresented: $presentManageTreatmentSheet) {
                        TreatmentEditableMenuView(isPresented: $presentManageTreatmentSheet)
                    }
                }
            }
            VStack {
                Text("My Symptoms")
                    .font(.headline)
                SymptomGridView(symptoms: symptoms)
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
