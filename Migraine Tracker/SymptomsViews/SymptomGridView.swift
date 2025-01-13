//
//  SymptomGridView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI

struct SymptomGridView: View {
    var symptoms: [Symptom]
    let columnLayout = Array(repeating: GridItem(alignment: .top), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout) {
                ForEach(symptoms.sorted(by: { $0.title < $1.title})) { symptom in
                    SymptomTileView(symptom: symptom)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    SymptomGridView(symptoms: [.init(title: "Test Symptom", icon: "cloud.circle.fill")])
}
