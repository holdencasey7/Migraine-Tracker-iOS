//
//  GenericHorizontalScrollTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct GenericHorizontalScrollTileView<T: GenericTriggerTreatmentSymptom>: View {
    var items: [T]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(items.sorted(by: { $0.title < $1.title})) { item in
                    GenericTileView(item: item)
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

//#Preview {
//    GenericHorizontalScrollTileView()
//}
