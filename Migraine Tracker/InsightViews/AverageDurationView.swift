//
//  AverageDurationView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/12/25.
//

import SwiftUI

struct AverageDurationView: View {
    var entries: [Entry]
    var body: some View {
        let validDurations = entries.compactMap { $0.duration }
        let averageDuration = validDurations.isEmpty ? 0 : validDurations.reduce(0, +) / Double(validDurations.count)
        VStack {
            if validDurations.isEmpty {
                Text("No entries with duration!")
                    .font(Font.custom("Avenir", size: Constants.averageDurationFontSize))
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                    .allowsTightening(true)
            } else {
                let hours = Int(averageDuration) / 3600
                let minutes = (Int(averageDuration) % 3600) / 60
                HStack {
                    Text("Average Duration:")
                        .font(Font.custom("Avenir", size: Constants.averageDurationFontSize))
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.8)
                        .lineLimit(2)
                        .allowsTightening(true)
                    Text(" \(hours)h \(minutes)m")
                        .font(Font.custom("Avenir", size: Constants.averageDurationFontSize))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .lineLimit(2)
                        .allowsTightening(true)
                }
            }
        }
    }
}

#Preview {
    AverageDurationView(entries: [])
}
