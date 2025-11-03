//
//  LogViewModel.swift
//  MacroMate
//
//  Created by Petar Iliev on 2.10.25.
//

import SwiftUI

extension LogView {
    @Observable
    class ViewModel {
        var name: String = ""
        var calorieString: String = ""
        var proteinString: String = ""
        var carbsString: String = ""
        var fatString: String = ""
        var timestamp: Date = .now
        
        private let onSave: (_: Food) -> Void
        
        init(onSave: @escaping (_: Food) -> Void) {
            self.onSave = onSave
        }
        
        var isButtonDisabled: Bool {
            !isFormValid
        }
        
        private var isFormValid: Bool {
            guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
            guard let cals = Double(calorieString), cals >= 0 else { return false }
            guard let prot = Double(proteinString), prot >= 0 else { return false }
            guard let carbs = Double(carbsString), carbs >= 0 else { return false }
            guard let fat = Double(fatString), fat >= 0 else { return false }
            return true
        }
        
        func saveButtonPressed() {
            let food = Food(
                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                calories: Double(calorieString) ?? 0,
                protein: Double(proteinString) ?? 0,
                carbs: Double(carbsString) ?? 0,
                fat: Double(fatString) ?? 0,
                timestamp: timestamp
            )
            onSave(food)
        }
    }
}
