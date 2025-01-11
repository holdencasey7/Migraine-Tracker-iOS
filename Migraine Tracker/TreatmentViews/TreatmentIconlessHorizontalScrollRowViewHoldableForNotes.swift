//
//  TreatmentIconlessHorizontalScrollRowViewHoldableForNotes.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/11/25.
//

import SwiftUI

struct TreatmentIconlessHorizontalScrollRowViewHoldableForNotes: View {
    var treatments: [Treatment]
    var entryDetailIn: Entry
    @State private var selectedTreatmentNote: TreatmentNote? = nil
    @State private var showSheet = false
    @State private var toggleBugFix: Bool = false

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .firstTextBaseline, spacing: Constants.genericIconlessHorizontalScrollRowViewHStackSpacing) {
                ForEach(treatments.sorted(by: { $0.title < $1.title }), id: \.id) { treatment in
                    GenericIconlessRowView(item: treatment, includeComma: treatments.sorted(by: { $0.title < $1.title }).last != treatment)
                        .onLongPressGesture {
                            if let treatmentNote = treatment.treatmentNotes.first(where: { $0.entryIn == entryDetailIn }) {
                                selectedTreatmentNote = treatmentNote
                                toggleBugFix.toggle()
                            }
                        }
                }
            }
            .frame(minHeight: 20)
        }
        .onChange(of: toggleBugFix) {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            // Present TreatmentNoteDetailView when the sheet is shown
            if let treatmentNote = selectedTreatmentNote {
                TreatmentNoteDetailView(treatmentNote: treatmentNote)
            }
        }
    }
}


//#Preview {
//    TreatmentIconlessHorizontalScrollRowViewHoldableForNotes()
//}
