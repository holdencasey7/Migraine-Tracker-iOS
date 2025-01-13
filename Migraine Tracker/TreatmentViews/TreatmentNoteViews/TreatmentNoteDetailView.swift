//
//  TreatmentDetailView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/9/25.
//

import SwiftUI

struct TreatmentNoteDetailView: View {
    var treatmentNote: TreatmentNote
    var body: some View {
        VStack {
            Text("Note for \(treatmentNote.treatmentIn?.title ?? "Unknown")")
            Text("Dosage: \(treatmentNote.dosage ?? "No dosage")")
            Text("Frequency: \(treatmentNote.frequency ?? 0)")
            if let datesTaken = treatmentNote.datesTaken {
                ForEach(datesTaken, id: \.self) { date in
                    Text("\(date)")
                }
            }
            Text("Duration: \(treatmentNote.duration ?? .zero)")
            Text("Notes: \(treatmentNote.otherNotes ?? "No notes")")
                .multilineTextAlignment(.leading)
        }
    }
}

//#Preview {
//    TreatmentNoteDetailView()
//}
