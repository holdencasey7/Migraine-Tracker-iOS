//
//  SelectAnyIconView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/21/25.
//

import SwiftUI

struct SelectAnyIconView: View {
    private static let allIcons: [String] = [
        "DefaultTreatmentIcon",
        "LifestyleTriggerIcon",
        "EnvironmentTriggerIcon",
        "DietTriggerIcon",
        "DefaultTriggerIcon",
        "HeadacheSymptomIcon",
        "NauseaSymptomIcon",
        "VisionLossSymptomIcon",
        "DizzinessSymptomIcon",
        "NeckPainSymptomIcon",
        "FatigueSymptomIcon",
        "NumbnessSymptomIcon",
    ]
    
    @Binding var selectedIcon: String
    var body: some View {
        IconPickerView(selectedIcon: $selectedIcon, icons: SelectAnyIconView.allIcons)
    }
}
//
//#Preview {
//    SelectAnyIconView()
//}
