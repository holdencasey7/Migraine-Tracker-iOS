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
    
    var body: some View {
        VStack {
            if let temp = temperature {
                Text("Temperature: \(String(format: "%.1f°F", temp))")
                    .font(.headline)
            } else {
                Text("Temperature: No data")
            }
            
            if let pressure = pressure {
                Text("Pressure: \(String(format: "%.2f inHg", pressure))")
                    .font(.headline)
            } else {
                Text("Pressure: No data")
            }
            
            if let condition = condition?.description {
                Text("Condition: \(condition)")
                    .font(.headline)
            } else {
                Text("Condition: No data")
            }
            
            if let humidity = humidity {
                Text("Humidity: \(String(format: "%.0f%%", humidity))")
                    .font(.headline)
            } else {
                Text("Humidity: No data")
            }
            
            if let pressureTrend = pressureTrend {
                HStack {
                    Text("Pressure Trend: ")
                        .font(.headline)
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
            } else {
                Text("Pressure Trend: No data")
            }
            
            

        }
    }
}

#Preview {
    WeatherView(temperature: 72.898, pressure: 30.045, condition: .cloudy, humidity: 88.93, pressureTrend: .rising)
}
