//
//  SwiftDataAppContainer.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 12/30/24.
//

import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        // Container
        let container = try ModelContainer(for: Entry.self, Trigger.self, Treatment.self, Symptom.self)
        
        // Check if symptoms already exist
        var symptomFetchDescriptor = FetchDescriptor<Symptom>()
        symptomFetchDescriptor.fetchLimit = 1
        guard try container.mainContext.fetch(symptomFetchDescriptor).count == 0 else { return container }
        
        // If not, add default symptoms
        let symptoms = [
            Symptom(title: "Headache", icon: "HeadacheSymptomIcon"),
            Symptom(title: "Nausea", icon: "NauseaSymptomIcon"),
            Symptom(title: "Vision Loss", icon: "VisionLossSymptomIcon"),
            Symptom(title: "Dizziness", icon: "DizzinessSymptomIcon"),
            Symptom(title: "Neck Pain", icon: "NeckPainSymptomIcon"),
            Symptom(title: "Fatigue", icon: "FatigueSymptomIcon"),
            Symptom(title: "Numbness", icon: "NumbnessSymptomIcon")
            
        ]
        for symptom in symptoms {
            container.mainContext.insert(symptom)
        }
        
        // Check if treatments already exist
        var treatmentFetchDescriptor = FetchDescriptor<Treatment>()
        treatmentFetchDescriptor.fetchLimit = 1
        guard try container.mainContext.fetch(treatmentFetchDescriptor).count == 0 else { return container }
        
        // If not, add default treatments
        let treatments = [
            Treatment(title: "Other Painkillers", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
            Treatment(title: "Excedrin", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
            Treatment(title: "Midol", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
            Treatment(title: "Other Triptan Class Drugs", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
            Treatment(title: "Imitrex", icon: "DefaultTreatmentIcon", category: TreatmentCategory.medicine),
            Treatment(title: "Herbal Tea", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
            Treatment(title: "Caffeine", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
            Treatment(title: "Steam", icon: "DefaultTreatmentIcon", category: TreatmentCategory.natural),
        ]
        for treatment in treatments {
            container.mainContext.insert(treatment)
        }
        
        
        // Check if triggers already exist
        var triggerFetchDescriptor = FetchDescriptor<Trigger>()
        triggerFetchDescriptor.fetchLimit = 1
        guard try container.mainContext.fetch(triggerFetchDescriptor).count == 0 else { return container }
        
        // If not, add default triggers
        let triggers = [
            Trigger(title: "Stress", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
            Trigger(title: "Poor Sleep", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
            Trigger(title: "Irregular Meals", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
            Trigger(title: "Physical Exertion", icon: "LifestyleTriggerIcon", category: TriggerCategory.lifestyle),
            Trigger(title: "Weather", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
            Trigger(title: "Lights", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
            Trigger(title: "Smells", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
            Trigger(title: "Noise", icon: "EnvironmentTriggerIcon", category: TriggerCategory.environment),
            Trigger(title: "Caffeine", icon: "DietTriggerIcon", category: TriggerCategory.diet),
            Trigger(title: "Alcohol", icon: "DietTriggerIcon", category: TriggerCategory.diet),
            Trigger(title: "MSG", icon: "DietTriggerIcon", category: TriggerCategory.diet),
            Trigger(title: "Nitrates", icon: "DietTriggerIcon", category: TriggerCategory.diet),
            Trigger(title: "Chocolate", icon: "DietTriggerIcon", category: TriggerCategory.diet),
            Trigger(title: "Medication", icon: "DefaultTriggerIcon", category: TriggerCategory.other),
            Trigger(title: "Hormones", icon: "DefaultTriggerIcon", category: TriggerCategory.other),
        ]
        for trigger in triggers {
            container.mainContext.insert(trigger)
        }
        
        return container
        
    } catch {
        fatalError("Failed to create container")
    }
} ()


