//
//  TriggerGridView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

@available(*, deprecated, message: "Use TriggerListView instead")
struct TriggerGridView: View {
    var triggers: [Trigger]
    @State var selectedTriggers: [Trigger]
    @Binding var finalSelectedTriggers: [Trigger]
    @Binding var presentTriggerSheet: Bool
    let columnLayout = Array(repeating: GridItem(), count: 3)
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(triggers) { trigger in
                        TriggerTileView(trigger: trigger, clickable: true)
                            .simultaneousGesture(TapGesture().onEnded{
                                if !selectedTriggers.contains(trigger) {
                                    selectedTriggers.append(trigger)
                                } else {
                                    selectedTriggers.removeAll(where: { $0 == trigger })
                                }
                            })
                    }
                }
            }
            ScrollView {
                VStack {
                    Text("Selected Triggers:")
                    ForEach(selectedTriggers) { trigger in
                        TriggerTileView(trigger: trigger, clickable: false)
                    }
                }
            }
            HStack {
                Spacer()
                Button(action: saveTriggers) {
                    Text("Save")
                }
                Spacer()
            }
        }
       
    }
    private func saveTriggers() {
        finalSelectedTriggers = selectedTriggers
        presentTriggerSheet = false
    }
}

//#Preview {
//    TriggerGridView(triggers: [.init(title: "Test1", icon: nil), .init(title: "Test2", icon: nil), .init(title: "Test3", icon: nil), .init(title: "Test4", icon: nil)], selectedTriggers: [], finalSelectedTriggers: .constant([]), presentTriggerSheet: .constant(false))
//}
