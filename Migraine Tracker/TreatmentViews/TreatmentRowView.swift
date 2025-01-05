//
//  TreatmentRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct TreatmentRowView: View {
    var treatment: Treatment
//    var body: some View {
//        HStack {
//            Image(systemName: treatment.icon ?? "pill.fill")
//            Text(treatment.title)
//        }
//    }
    var body: some View {
        GenericRowView<Treatment>(item: treatment)
    }
}

#Preview {
    TreatmentRowView(treatment: .init(title: "Placeholder Treatment", icon: "pill.fill", category: .medicine))
}
