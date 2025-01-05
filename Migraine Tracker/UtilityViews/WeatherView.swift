//
//  WeatherView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            Text("Weather App")
                .font(.largeTitle)
            Text("Condition: \(viewModel.condition)")
            Text("Temperature: \(viewModel.temperature)")
            Text("Pressure: \(viewModel.pressure)") 
        }
        .padding()
    }
}

#Preview {
    WeatherView()
}
