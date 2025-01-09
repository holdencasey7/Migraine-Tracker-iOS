//
//  CreateTreatmentNoteView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/9/25.
//

import SwiftUI

struct CreateTreatmentNoteView: View {
    @Binding var treatment: Treatment
    @Binding var allEntryTreatmentNotes: [TreatmentNote]
    @State var treatmentNote: TreatmentNote = TreatmentNote()
    
    @State var dosage: String?
    @State var frequency: Int?
    @State var datesTaken: [Date]?
    @State var duration: TimeInterval?
    @State var otherNotes: String?
    
    var body: some View {
        VStack {
            Text(treatment.title)
        }
        .onAppear {
            dosage = treatment.defaultDosage
            frequency = treatment.defaultFrequency
            duration = treatment.defaultDurartion
            otherNotes = treatment.defaultOtherNotes
        }
    }
    
    private func submit() {
        treatment.treatmentNotes.append(treatmentNote)
        allEntryTreatmentNotes.append(treatmentNote)
    }
}

//#Preview {
//    CreateTreatmentNoteView()
//}
