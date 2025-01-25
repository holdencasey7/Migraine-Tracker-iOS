//
//  IconPickerView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/31/24.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    var icons: [String]
    @State var tempSelectedIcon: String = ""
    
    var body: some View {
//        GeometryReader { geometry in
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(icons, id: \.self) { icon in
                            Button(action: {
                                selectedIcon = icon
                                tempSelectedIcon = icon
                            }) {
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(1, contentMode: .fit)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: Constants.anyIconSelectRoundedRectangleCornerRadius)
                                            .fill(tempSelectedIcon == icon ? Color("LightGrey") : Color.clear)
                                    )
                            }
                        }
                    }
//                    .frame(minWidth: geometry.size.width,
//                            alignment: .center)
                }
            }
            .onAppear {
                tempSelectedIcon = selectedIcon
            }
//        }
    }
}

#Preview {
    IconPickerView(selectedIcon: .constant(""), icons: [
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
    ])
}
