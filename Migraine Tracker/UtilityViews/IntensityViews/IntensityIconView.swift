//
//  IntensityIconView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/29/24.
//

import SwiftUI

struct IntensityIconView: View {
    var intensity: Int
    var body: some View {
        Image(systemName: "\(intensity).square.fill")
            .font(.title)
            .foregroundColor(intensity == 5 ? .red : intensity == 4 ? .orange : intensity == 3 ? .yellow : intensity == 2 ? .green : .teal)
    }
}

#Preview {
    IntensityIconView(intensity: 2)
}
