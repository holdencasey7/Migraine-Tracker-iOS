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
            HStack(alignment: .top ,spacing: Constants.genericHorizontalScrollTileViewHStackSpacing) {
                ForEach(items.sorted(by: { $0.title < $1.title})) { item in
                    GenericTileView(item: item)
                }
            }
        }
    }
}

#Preview {
    GenericHorizontalScrollTileView(items: [
        Trigger(title: "s", icon: "DefaultTriggerIcon"),
        Trigger(title: "Physical Exertion", icon: "DefaultTriggerIcon"),
        Trigger(title: "Test Trigger", icon: "DefaultTriggerIcon"),
        Trigger(title: "Test Trigger", icon: "DefaultTriggerIcon"),
        Trigger(title: "Test Trigger", icon: "DefaultTriggerIcon"),
    ])
}
