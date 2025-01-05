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
    
    @Published var temperature: String = "--"
    @Published var condition: String = "Loading..."
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            DispatchQueue.main.async {
                self.temperature = "\(weather.currentWeather.temperature.value)°C"
                self.condition = weather.currentWeather.condition.description
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
    }

    // ✅ Conformance to CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Task {
            await fetchWeather(for: location)
        }
        locationManager.stopUpdatingLocation()  // Stop for battery efficiency
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
