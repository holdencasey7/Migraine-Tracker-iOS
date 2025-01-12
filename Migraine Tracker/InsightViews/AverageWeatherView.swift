//
//  AverageWeatherView.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/12/25.
//

import SwiftUI
import Foundation
import WeatherKit

struct AverageWeatherView: View {
    var entries: [Entry]
    var body: some View {
        let (avgTemp, mostCommonCondition, avgPressure, avgHumidity, mostCommonPressureTrend, mostCommonConditionSymbol) = analyzeWeatherData(entries: entries)
        VStack {
            Text("Average Weather:")
                .font(Font.custom("Avenir", size: Constants.averageWeatherFontSize))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .allowsTightening(true)
            WeatherView(temperature: avgTemp, pressure: avgPressure, condition: mostCommonCondition, humidity: avgHumidity, pressureTrend: mostCommonPressureTrend, conditionSymbol: mostCommonConditionSymbol)
        }
    }
    
    func analyzeWeatherData(entries: [Entry]) -> (avgTemp: Double, mostCommonCondition: WeatherCondition?, avgPressure: Double, avgHumidity: Double, mostCommonPressureTrend: PressureTrend?, mostCommonConditionSymbol: String?) {
        
        var totalTemp = 0.0
        var tempCount = 0
        var conditionCounts = [WeatherCondition: Int]()
        var totalPressure = 0.0
        var pressureCount = 0
        var totalHumidity = 0.0
        var humidityCount = 0
        var pressureTrendCounts = [PressureTrend: Int]()
        var conditionSymbolCounts = [String: Int]()

        for entry in entries {
            if let temp = entry.temperature {
                totalTemp += temp
                tempCount += 1
            }
            if let condition = entry.condition {
                conditionCounts[condition, default: 0] += 1
            }
            if let pressure = entry.pressure {
                totalPressure += pressure
                pressureCount += 1
            }
            if let humidity = entry.humidity {
                totalHumidity += humidity
                humidityCount += 1
            }
            if let pressureTrend = entry.pressureTrend {
                pressureTrendCounts[pressureTrend, default: 0] += 1
            }
            if let conditionSymbol = entry.conditionSymbol {
                conditionSymbolCounts[conditionSymbol, default: 0] += 1
            }
        }

        let avgTemp = tempCount > 0 ? totalTemp / Double(tempCount) : 0.0
        let mostCommonCondition = conditionCounts.max(by: { $0.value < $1.value })?.key
        let avgPressure = pressureCount > 0 ? totalPressure / Double(pressureCount) : 0.0
        let avgHumidity = humidityCount > 0 ? totalHumidity / Double(humidityCount) : 0.0
        let mostCommonPressureTrend = pressureTrendCounts.max(by: { $0.value < $1.value })?.key
        let mostCommonConditionSymbol = conditionSymbolCounts.max(by: { $0.value < $1.value })?.key

        return (avgTemp, mostCommonCondition, avgPressure, avgHumidity, mostCommonPressureTrend, mostCommonConditionSymbol)
    }




}

#Preview {
    AverageWeatherView(entries: [])
}
