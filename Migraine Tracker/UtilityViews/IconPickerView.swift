//
//  IconPickerView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/31/24.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    var icons: [String] = ["heart", "pill", "star", "cloud.circle"]
    @State var tempSelectedIcon: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Icon Picker View Placeholder")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(icons, id: \.self) { icon in
                            Button(action: {
                                selectedIcon = icon
                                tempSelectedIcon = icon
                            }) {
                                let iconName = tempSelectedIcon == icon ? "\(icon).fill" : icon
                                Image(systemName: iconName)
                            }
                        }
                    }
                    .frame(minWidth: geometry.size.width,
                            alignment: .center)
                }
            }
        }
    }
}

#Preview {
    IconPickerView(selectedIcon: .constant(""))
}
