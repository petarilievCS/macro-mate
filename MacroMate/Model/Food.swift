//
//  Food.swift
//  MacroMate
//
//  Created by Petar Iliev on 30.9.25.
//

import Foundation
import SwiftData

@Model
final class Food: Identifiable, Sendable {
    var id: UUID
    var name: String
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
    var timestamp: Date
    
    init(name: String, calories: Double, protein: Double, carbs: Double, fat: Double, timestamp: Date) {
        self.id = UUID()
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.timestamp = timestamp
    }
}

