//
//  Entry.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/27/24.
//

import Foundation
import SwiftData
import WeatherKit

@Model
final class Entry:Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var intensity: Int
    @Relationship var triggers: [Trigger]
    @Relationship var symptoms: [Symptom]
    @Relationship var treatments: [Treatment]
    var notes: String
    @Relationship(deleteRule: .cascade) var followup: Followup?
    var temperature: Double?
    var condition: WeatherCondition?
    var pressure: Double?
    var humidity: Double?
    var pressureTrend: PressureTrend?
    var conditionSymbol: String?
    
    
    init(timestamp: Date, intensity: Int, triggers: [Trigger], symptoms: [Symptom], treatments: [Treatment], notes: String, temperature: Double? = nil, condition: WeatherCondition? = nil, pressure: Double? = nil, humidity: Double? = nil, pressureTrend: PressureTrend? = nil, conditionSymbol: String? = nil) {
        self.id = UUID()
        
        if intensity < Constants.minIntensity {
            self.intensity = Constants.minIntensity
        } else if intensity > Constants.maxIntensity {
            self.intensity = Constants.maxIntensity
        } else {
            self.intensity = intensity
        }
        
        self.timestamp = timestamp

        self.triggers = triggers
        self.symptoms = symptoms
        self.treatments = treatments
        self.notes = notes
        
        self.temperature = temperature
        self.condition = condition
        self.pressure = pressure
        self.humidity = humidity
        self.pressureTrend = pressureTrend
        self.conditionSymbol = conditionSymbol
        
        for trigger in triggers {
            trigger.entriesIn.append(self)
        }
        for symptom in symptoms {
            symptom.entriesIn.append(self)
        }
        for treatment in treatments {
            treatment.entriesIn.append(self)
        }
    }
    
    convenience init(timestamp: Date, intensity: Int, notes: String) {
        let triggers: [Trigger] = []
        let symptoms: [Symptom] = []
        let treatments: [Treatment] = []
        self.init(timestamp: timestamp, intensity: intensity, triggers: triggers, symptoms: symptoms, treatments: treatments, notes: notes)
    }
}
