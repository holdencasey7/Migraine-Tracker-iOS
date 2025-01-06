//
//  WeatherView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var weather: WeatherViewModel
    
    var body: some View {
        VStack {
            if let temp = weather.temperature {
                Text("Temperature: \(String(format: "%.1f°F", temp))")
                    .font(.headline)
            } else {
                Text("Fetching temperature...")
            }
            
            if let pressure = weather.pressure {
                Text("Pressure: \(String(format: "%.2f inHg", pressure))")
                    .font(.headline)
            } else {
                Text("Fetching pressure...")
            }
            
            if let condition = weather.condition {
                Text("Condition: \(condition)")
                    .font(.headline)
            } else {
                Text("Fetching condition...")
            }
            
            if let humidity = weather.humidity {
                Text("Humidity: \(String(format: "%.0f%%", humidity))")
                    .font(.headline)
            } else {
                Text("Fetching humidity...")
            }
            
            if let pressureTrend = weather.pressureTrend {
                Text("Pressure Trend: \(pressureTrend)")
                    .font(.headline)
            } else {
                Text("Fetching pressure trend...")
            }
            
            

        }
    }
}

#Preview {
    WeatherView(weather: WeatherViewModel())
}
