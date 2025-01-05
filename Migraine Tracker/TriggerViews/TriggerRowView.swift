//
//  TriggerRowView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct TriggerRowView: View {
    var trigger: Trigger
    var body: some View {
        GenericRowView<Trigger>(item: trigger)
    }
}

#Preview {
    TriggerRowView(trigger: .init(title: "Placeholder Trigger", icon: "flag.fill"))
}
