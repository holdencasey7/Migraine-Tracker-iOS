//
//  CreateTreatmentNoteView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/9/25.
//

import SwiftUI

struct CreateTreatmentNoteView: View {
    var treatment: Treatment
    @Binding var allEntryTreatmentNotes: [TreatmentNote]
    @Binding var isPresented: Bool
    
    @State var dosage: String?
    @State var frequency: Int?
    @State var datesTaken: [Date]?
    @State var duration: TimeInterval?
    @State var otherNotes: String?
    
    var body: some View {
        VStack {
            Text("Hello")
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
        let treatmentNote: TreatmentNote = TreatmentNote(treatmentIn: treatment)
        
        if let dosage {
            treatmentNote.dosage = dosage
        }
        if let frequency {
            treatmentNote.frequency = frequency
        }
        if let datesTaken {
            treatmentNote.datesTaken = datesTaken
        }
        if let duration {
            treatmentNote.durartion = duration
        }
        if let otherNotes {
            treatmentNote.otherNotes = otherNotes
        }
        
        allEntryTreatmentNotes.append(treatmentNote)
        isPresented = false
    }
}

//#Preview {
//    CreateTreatmentNoteView()
//}
