//
//  IntensityFractionView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/3/25.
//

import SwiftUI

struct IntensityFractionView: View {
    var intensity: Int
    var body: some View {
        VStack {
            ZStack {
                Image("\(intensity)_\(Constants.maxIntensity)_Circle")
                    .resizable()
                    .frame(width: 125, height: 125)
                Text("\(intensity)/\(Constants.maxIntensity)")
                    .font(Font.custom("Avenir", size: Constants.intensityFractionFontSize))
            }
            Text("INTENSITY")
                .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                .kerning(3)
        }
    }
}

#Preview {
    IntensityFractionView(intensity: 2)
}
