//
//  TriggerTileView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

@available(*, deprecated, message: "Use TriggerRowView instead")
struct TriggerTileView: View {
    var trigger: Trigger
    @State private var selected: Bool = false
    var clickable: Bool
    var body: some View {
        Text("\(trigger.title)")
            .padding(5)
            .background(selected&&clickable ? Color.blue : Color.red, in: RoundedRectangle(cornerRadius: 5))
            .simultaneousGesture(TapGesture().onEnded{
                selected.toggle()
            })
    }
}

//#Preview {
//    TriggerTileView(trigger: .init(title: "Test", icon: nil), clickable: true)
//}
