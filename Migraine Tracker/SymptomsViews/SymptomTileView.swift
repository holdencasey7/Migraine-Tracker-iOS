//
//  SymptomTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/1/25.
//

import SwiftUI

struct SymptomTileView: View {
    var symptom: Symptom
    var body: some View {
        GenericTileView(item: symptom)
    }
}

#Preview {
    SymptomTileView(symptom: .init(title: "Test Symptom", icon: "DefaultSymptomIcon"))
}
