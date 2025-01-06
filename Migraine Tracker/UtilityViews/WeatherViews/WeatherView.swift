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
        HStack(spacing: 35) {
            if let temp = temperature {
                Text("\(String(format: "%.0f°F", temp))")
                    .font(Font.custom("Avenir", size: 17))
            } else {
                Text("--°F")
                    .font(Font.custom("Avenir", size: 17))
            }
            
            if let conditionSymbol = conditionSymbol {
                Image(systemName: conditionSymbol)
            } else {
                Image(systemName: "questionmark")
            }
            
            if let pressure = pressure {
                HStack(alignment: .lastTextBaseline, spacing: 1) {
                    Text("\(String(format: "%.2f\"Hg", pressure))")
                        .font(Font.custom("Avenir", size: 17))
                    if let pressureTrend = pressureTrend {
                        if pressureTrend == .falling {
                            Image(systemName: "arrow.down.circle")
                        } else if pressureTrend == .rising {
                            Image(systemName: "arrow.up.circle")
                        } else if pressureTrend == .steady {
                            Image(systemName: "arrow.right.circle")
                        } else {
                            Image(systemName: "arrow.right.circle")
                        }
                    }
                }
            } else {
                Text("--\"Hg")
                    .font(Font.custom("Avenir", size: 17))
            }
            
            if let humidity = humidity {
                HStack(alignment: .lastTextBaseline, spacing: 1) {
                    Text("\(String(format: "%.0f%%", humidity))")
                        .font(Font.custom("Avenir", size: 17))
                    Image(systemName: "humidity")
                }
            } else {
                HStack(alignment: .lastTextBaseline, spacing: 1) {
                    Text("--%")
                        .font(Font.custom("Avenir", size: 17))
                    Image(systemName: "humidity")
                }
            }
        }
        .padding()
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

#Preview {
    WeatherView(temperature: 101.55, pressure: 30.045, condition: .freezingDrizzle, humidity: 89.88, pressureTrend: .rising, conditionSymbol: "cloud")
}
