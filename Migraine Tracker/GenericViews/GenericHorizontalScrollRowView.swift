//
//  GenericHorizontalScrollRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct GenericHorizontalScrollRowView<T: GenericTriggerTreatmentSymptom>: View {
    var items: [T]
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                ForEach(items.sorted(by: { $0.title < $1.title
                })) { item in
                    GenericRowView<T>(item: item)
                }
            }
        }
    }
}

//#Preview {
//    GenericHorizontalScrollRowView()
//}
