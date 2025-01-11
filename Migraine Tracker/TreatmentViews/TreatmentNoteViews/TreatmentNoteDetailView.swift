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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text(treatmentNote.dosage ?? "No dosage")
    }
}

//#Preview {
//    TreatmentNoteDetailView()
//}
