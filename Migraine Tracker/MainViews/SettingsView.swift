//
//  SettingsView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/6/25.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Version", value: "Beta 1.0")
                    LabeledContent("Developed By", value: "Holden Casey")
                    LabeledContent("Designed By", value: "Sophia Casey")
                } header: {
                    Text("About")
                }

                Section {
                    NavigationLink("Triggers") {
                        TriggerEditableMenuView()
                    }
                    NavigationLink("Treatments") {
                        TreatmentEditableMenuView()
                    }
                    NavigationLink("Symptoms") {
                        SymptomEditableMenuView()
                    }
                } header: {
                    Text("Manage Items")
                }
                
//                Section {
//                    Text("Placeholder")
//                } header: {
//                    Text("Other")
//                }
//                
//                Section {
//                    Button("Reset All Content and Settings") {
//                    
//                    }
//                    .foregroundColor(.red)
//                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
