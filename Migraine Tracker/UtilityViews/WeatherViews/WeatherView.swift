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
            
            Text("Condition: \(weather.condition)")
                .font(.subheadline)
                .padding(.top, 10)
        }
    }
}

#Preview {
    WeatherView(weather: WeatherViewModel())
}
