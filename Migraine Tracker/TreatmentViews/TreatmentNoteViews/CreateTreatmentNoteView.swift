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
    
    @State var dosage: String = ""
    @State var frequency: Int = 0
    @State var datesTaken: [Date] = []
    @State var duration: TimeInterval = .zero
    @State var otherNotes: String = ""
    
    var body: some View {
        VStack {
            Text("Note for \(treatment.title)")
                .font(Font.custom("Avenir", size: Constants.headerFontSize))
                .kerning(Constants.subtitleKerning)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .padding()
            
            Form {
                TextField("Dosage", text: $dosage)
                    .autocapitalization(.none)
                    .padding()
                
                TextField("Frequency", value: $frequency, format: .number)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(.numberPad)
            }
            Button(action: submit) {
                Text("Submit")
                    .modifier(RoundedPinkButtonStyle())
            }
        }
        .onAppear {
            let previousNote = allEntryTreatmentNotes.first { $0.treatmentIn == treatment }
            if let previousNote {
                if previousNote.dosage != nil {
                    dosage = previousNote.dosage!
                }
                if previousNote.frequency != nil {
                    frequency = previousNote.frequency!
                }
                if previousNote.datesTaken != nil {
                    datesTaken = previousNote.datesTaken!
                }
                if previousNote.durartion != nil {
                    duration = previousNote.durartion!
                }
                if previousNote.otherNotes != nil {
                    otherNotes = previousNote.otherNotes!
                }
            } else {
                dosage = treatment.defaultDosage ?? ""
                frequency = treatment.defaultFrequency ?? 0
                duration = treatment.defaultDurartion ?? .zero
                otherNotes = treatment.defaultOtherNotes ?? ""
                datesTaken = [Date()]
            }
        }
    }
    
    private func submit() {
        let treatmentNote: TreatmentNote = TreatmentNote(treatmentIn: treatment)
        
        
            treatmentNote.dosage = dosage
        
        
            treatmentNote.frequency = frequency
        
        
            treatmentNote.datesTaken = datesTaken
        
        
            treatmentNote.durartion = duration
        
        
            treatmentNote.otherNotes = otherNotes
        
        
        allEntryTreatmentNotes.append(treatmentNote)
        isPresented = false
    }
}

//#Preview {
//    CreateTreatmentNoteView()
//}
