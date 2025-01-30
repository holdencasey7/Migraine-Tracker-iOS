//
//  TreatmentDetailView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/9/25.
//

import SwiftUI

struct TreatmentNoteDetailView: View {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy 'at' hh:mm a"
        return formatter
    }()
    
    func formattedDuration(for duration: TimeInterval) -> String {
        if duration < 60 {
            let seconds = Int(duration)
            return "\(seconds) second\(seconds != 1 ? "s" : "")"
        }
        
        let totalMinutes = Int(duration) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        if hours > 0 {
            if minutes > 0 {
                return "\(hours) hour\(hours > 1 ? "s" : "") \(minutes) minute\(minutes > 1 ? "s" : "")"
            } else {
                return "\(hours) hour\(hours > 1 ? "s" : "")"
            }
        } else {
            return "\(minutes) minute\(minutes > 1 ? "s" : "")"
        }
    }
    
    var treatmentNote: TreatmentNote
    var body: some View {
        ZStack {
            Color("Pink1").edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Text("Note for \(treatmentNote.treatmentIn?.title ?? "Unknown")")
                        .font(Font.custom("Avenir", size: Constants.headerFontSize))
                        .kerning(Constants.subtitleKerning)
                        .padding()
                    if let dosage = treatmentNote.dosage {
                        if !dosage.isEmpty {
                            Spacer()
                            Text("Dosage: \(dosage)")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .minimumScaleFactor(0.9)
                                .lineLimit(1)
                                .allowsTightening(true)
                                .padding()
                                .frame(width: geometry.size.width * 0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                )
                        }
                    }
                    
                    if let datesTaken = treatmentNote.datesTaken {
                        Spacer()
                        ScrollView {
                            VStack{
                                ForEach(datesTaken, id: \.self) { date in
                                    Text("\(date, formatter: dateFormatter)")
                                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                        .minimumScaleFactor(0.9)
                                        .lineLimit(1)
                                        .allowsTightening(true)
                                        .padding(.horizontal)
                                }
                            }.padding()
                        }
                        .frame(width: geometry.size.width * 0.9, height: min(CGFloat(datesTaken.count * 50), 100))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        
                    }
                    
                    if let duration = treatmentNote.duration {
                        if !duration.isZero {
                            Spacer()
                            Text("Duration: \(formattedDuration(for: duration))")
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .minimumScaleFactor(0.9)
                                .lineLimit(1)
                                .allowsTightening(true)
                                .padding()
                            //                    .padding(.top)
                                .frame(width: geometry.size.width * 0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                )
                        }
                    }
                    
                    if let notes = treatmentNote.otherNotes {
                        if !notes.isEmpty {
                            Spacer()
                            Text("Notes: \(notes)")
                                .multilineTextAlignment(.leading)
                                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                                .minimumScaleFactor(0.9)
                                .allowsTightening(true)
                                .padding()
                                .frame(width: geometry.size.width * 0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                )
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    let treatment: Treatment = .init(title: "TreatName", icon: "DefaultTreatmentIcon", category: .other)
    let duration: TimeInterval = 640000
    let treatmentNote: TreatmentNote = .init(treatmentIn: treatment)
    TreatmentNoteDetailView(treatmentNote: treatmentNote)
        .onAppear {
            treatmentNote.dosage = "1000 mg"
            treatmentNote.frequency = 2
            treatmentNote.datesTaken = [Date(), Date()]
            treatmentNote.duration = duration
            treatmentNote.otherNotes = "This is a note that is longer than the default note length and should cause the scroll view to scroll and display the e"
        }
}
