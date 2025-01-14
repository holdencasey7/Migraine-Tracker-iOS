//
//  IntensityIconView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct IntensityIconView: View {
    var intensity: Int
    var color: String = "Blue"
    var body: some View {
        Image(systemName: "\(intensity).square.fill")
            .font(.title)
            .foregroundColor(Color("\(color)\(intensity)"))
    }
}

#Preview {
    IntensityIconView(intensity: 5)
}
