//
//  FollowupView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI
import SwiftData

struct CreateFollowupView: View {
    @Binding var entry: Entry
    @Environment(\.modelContext) private var modelContext
    
    @State var newIntensity: Int = 0
    @State var newSymptoms: [Symptom] = []
    @State var symptomRatings: [Symptom: Int] = [:]
    @State var endDate: Date = Date()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    private func addFollowup() {
        let followup: Followup = .init(entry: entry)
        modelContext.insert(followup)
        try? modelContext.save()
        // I shouldn't need to do entry.followup = followup because it's in the init() of Followup
        
    }
}

//#Preview {
//    CreateFollowupView()
//}
