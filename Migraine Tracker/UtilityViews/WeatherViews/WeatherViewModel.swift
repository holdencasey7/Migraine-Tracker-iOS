//
//  WeatherViewModel.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/5/25.
//

import SwiftUI
@preconcurrency import WeatherKit
import CoreLocation

@preconcurrency
class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let weatherService = WeatherService()
    private var locationManager = CLLocationManager()
    
    @Published var temperature: Double?
    @Published var condition: WeatherCondition?
    @Published var pressure: Double?
    @Published var humidity: Double?
    @Published var pressureTrend: PressureTrend?
    @Published var conditionSymbol: String?
    
    private var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Fetch weather based on the current location and call completion with success status
    func fetchWeather(completion: @escaping (Bool) -> Void) async {
        guard let location = currentLocation else {
            print("Error: No location available.")
            completion(false) // Return failure if no location
            return
        }
        
        do {
            let weather = try await weatherService.weather(for: location)
            DispatchQueue.main.async {
                self.temperature = weather.currentWeather.temperature.converted(to: .fahrenheit).value
                self.pressure = weather.currentWeather.pressure.converted(to: .inchesOfMercury).value
                self.condition = weather.currentWeather.condition
                self.humidity = weather.currentWeather.humidity * 100
                self.pressureTrend = weather.currentWeather.pressureTrend
                self.conditionSymbol = weather.currentWeather.symbolName
                
                completion(true)  // Return success once data is fetched
            }
        } catch {
            print("Error fetching weather: \(error)")
            completion(false) // Return failure in case of error
        }
    }

    // Conformance to CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location  // Store the most recent location
        Task {
            await fetchWeather { success in
                if success {
                    print("Weather data fetched successfully")
                } else {
                    print("Failed to fetch weather data")
                }
            }
        }
        locationManager.stopUpdatingLocation()  // Stop for battery efficiency
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

