//
//  GenericListView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/2/25.
//

import SwiftUI

struct GenericListView<T: GenericTriggerTreatmentSymptom>: View {
    var items: [T]
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.genericListViewVStackSpacing) {
                    ForEach(items.sorted(by: { $0.title < $1.title
                    })) { item in
                        GenericRowView<T>(item: item)
                            .frame(height: geometry.size.width * 0.15)
                    }
                }
            }
        }
    }
}

//#Preview {
//    GenericListView()
//}
