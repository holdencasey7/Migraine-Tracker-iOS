//
//  GenericRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/2/25.
//

import SwiftUI

struct GenericRowView<T : GenericTriggerTreatmentSymptom>: View {
    var item: T
    var body: some View {
        HStack {
            Image(item.icon ?? "DefaultTriggerIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30)
            Text(item.title)
                .font(Font.custom("Avenir", size: 19))
        }
    }
}

//#Preview {
//    GenericRowView()
//}
