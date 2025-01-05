//
//  TriggerListView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct TriggerListView: View {
    var triggers: [Trigger]
    var body: some View {
        GenericListView<Trigger>(items: triggers)
    }
}

#Preview {
    TriggerListView(triggers: [])
}
