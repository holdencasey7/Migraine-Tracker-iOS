//
//  WeatherView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct WeatherView: View {
    @State var temperature: Double?
    @State var pressure: Double?
    @State var condition: String?
    @State var humidity: Double?
    @State var pressureTrend: String?
    
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
            
            if let condition = condition {
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
                Text("Pressure Trend: \(pressureTrend)")
                    .font(.headline)
            } else {
                Text("Pressure Trend: No data")
            }
            
            

        }
    }
}

#Preview {
    let weather = WeatherViewModel()
    WeatherView(temperature: weather.temperature, pressure: weather.pressure, condition: weather.condition, humidity: weather.humidity, pressureTrend: weather.pressureTrend)
}
