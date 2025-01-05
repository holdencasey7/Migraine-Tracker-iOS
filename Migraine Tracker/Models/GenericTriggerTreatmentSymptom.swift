//
//  GenericTriggerOrTreatment.swift
//  Migraine Tracker
//
//  Created by Holden Casey on 1/2/25.
//

import Foundation
import SwiftData

protocol GenericTriggerTreatmentSymptom: Identifiable, Equatable {
    var id: UUID { get set }
    var title: String { get set }
    var icon: String? { get set }
}
