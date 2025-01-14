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
            .foregroundColor(Color("Blue\(intensity)"))
    }
}

#Preview {
    IntensityIconView(intensity: 5)
}
