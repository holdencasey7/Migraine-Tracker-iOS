//
//  SymptomListView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct SymptomListView: View {
    var symptoms: [Symptom]
    var body: some View {
        GenericListView(items: symptoms)
    }
}

//#Preview {
//    SymptomListView()
//}
