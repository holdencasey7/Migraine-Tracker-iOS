//
//  TreatmentListView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct TreatmentListView: View {
    var treatments: [Treatment]
    var body: some View {
        GenericListView<Treatment>(items: treatments)
    }
}

#Preview {
    TreatmentListView(treatments: [])
}
