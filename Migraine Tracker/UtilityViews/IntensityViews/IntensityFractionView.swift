//
//  IntensityFractionView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct IntensityFractionView: View {
    var intensity: Int
    let maxIntensity: Int = 5
    var body: some View {
        VStack {
            ZStack {
                Image("\(intensity)_5_Circle")
                    .resizable()
                    .frame(width: 125, height: 125)
                Text("\(intensity)/\(maxIntensity)")
                    .font(Font.custom("Avenir", size: 25))
            }
            Text("INTENSITY")
                .font(Font.custom("Avenir", size: 17))
                .kerning(3)
        }
    }
}

#Preview {
    IntensityFractionView(intensity: 4)
}
