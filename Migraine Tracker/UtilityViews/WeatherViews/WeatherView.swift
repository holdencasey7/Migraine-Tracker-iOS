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
        VStack {
            Text("WEATHER")
                .font(Font.custom("Avenir", size: 19))
                .kerning(Constants.kerningSubtitle)
                .padding(3)
                .padding(.horizontal, 53.5)
                .padding(.bottom, 2)
                .padding(.top, 2)
                .background(Color("FirstLightPink"))
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 29,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 29,
                    style: .continuous
                ))
            VStack {
                if let temp = temperature {
                    Text("Temperature: \(String(format: "%.1f°F", temp))")
                        .font(Font.custom("Avenir", size: 17))
                } else {
                    Text("Temperature: No data")
                        .font(Font.custom("Avenir", size: 17))
                }
                
                if let pressure = pressure {
                    HStack {
                        Text("Pressure: \(String(format: "%.2f inHg", pressure))")
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
                    Text("Pressure: No data")
                        .font(Font.custom("Avenir", size: 17))
                }
                
                if let condition = condition?.description {
                    HStack {
                        Text("Condition: \(condition)")
                            .font(Font.custom("Avenir", size: 17))
                        if let conditionSymbol = conditionSymbol {
                            Image(systemName: conditionSymbol)
                        }
                    }
                } else {
                    Text("Condition: No data")
                        .font(Font.custom("Avenir", size: 19))
                }
                
                if let humidity = humidity {
                    Text("Humidity: \(String(format: "%.0f%%", humidity))")
                        .font(Font.custom("Avenir", size: 17))
                } else {
                    Text("Humidity: No data")
                        .font(Font.custom("Avenir", size: 17))
                }
            }
            .padding(5)
            .padding(.horizontal, 7)
            .padding(.bottom, 5)
            .padding(.top, -7)
        }
        .frame(width: 224, height: 145)
        .padding(.top, 1.1)
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
