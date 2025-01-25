//
//  WeatherView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI
import WeatherKit

struct WeatherView: View {
    @State var temperature: Double?
    @State var pressure: Double?
    @State var condition: WeatherCondition?
    @State var humidity: Double?
    @State var pressureTrend: PressureTrend?
    @State var conditionSymbol: String?
    
    var body: some View {
        HStack {
            if temperature == nil && pressure == nil && condition == nil && humidity == nil && pressureTrend == nil {
                Text("Weather Unavailable for Past Date")
                    .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .allowsTightening(true)
            } else {
                Spacer()
                if let temp = temperature {
                    Text("\(String(format: "%.0f°F", temp))")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                        .allowsTightening(true)
                } else {
                    Text("--°F")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                Spacer()
                if let conditionSymbol = conditionSymbol {
                    Image(systemName: conditionSymbol)
                } else {
                    Image(systemName: "questionmark")
                }
                Spacer()
                if let pressure = pressure {
                    HStack(alignment: .lastTextBaseline, spacing: Constants.weatherViewInnerHStackSpacing) {
                        Text("\(String(format: "%.2f\"Hg", pressure))")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .allowsTightening(true)
                        if let pressureTrend = pressureTrend {
                            if pressureTrend == .falling {
                                Image(systemName: "arrow.down.circle")
                            } else if pressureTrend == .rising {
                                Image(systemName: "arrow.up.circle")
                            } else if pressureTrend == .steady {
                                Image(systemName: "equal.circle")
                            } else {
                                Image(systemName: "equal.circle")
                            }
                        }
                    }
                } else {
                    Text("--\"Hg")
                        .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                }
                Spacer()
                if let humidity = humidity {
                    HStack(alignment: .lastTextBaseline, spacing: Constants.weatherViewInnerHStackSpacing) {
                        Text("\(String(format: "%.0f%%", humidity))")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .allowsTightening(true)
                        Image(systemName: "humidity")
                    }
                } else {
                    HStack(alignment: .lastTextBaseline, spacing: Constants.weatherViewInnerHStackSpacing) {
                        Text("--%")
                            .font(Font.custom("Avenir", size: Constants.subtitleFontSize))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .allowsTightening(true)
                        Image(systemName: "humidity")
                    }
                }
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.weatherViewRoundedRectangleCornerRadius, style: .continuous)
                .fill(Color.white)
                .stroke(Color.black, lineWidth: Constants.weatherViewRoundedRectanlgeBorderWidth)
        )
        .padding(.horizontal)
    }
}

#Preview {
    WeatherView(temperature: nil, pressure: nil, condition: nil, humidity: nil, pressureTrend: nil, conditionSymbol: "cloud")
}
