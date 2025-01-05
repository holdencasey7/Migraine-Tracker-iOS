//
//  SymptomHorizontalScrollTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI

struct SymptomHorizontalScrollTileView: View {
    var symptoms: [Symptom]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(symptoms.sorted(by: { $0.title < $1.title})) { symptom in
                    SymptomTileView(symptom: symptom)
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

#Preview {
    SymptomHorizontalScrollTileView(symptoms: [])
}
