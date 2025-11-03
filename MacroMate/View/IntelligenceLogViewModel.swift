//
//  IntelligenceLogViewModel.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

import Foundation
import SwiftUI

extension IntelligenceLogView {
    @Observable
    class ViewModel {
        let llmService: LLMServiceProviding
        let dataService: DataServiceProviding
        
        var description: String = ""
        var isLoading: Bool = false
        var hasResult: Bool = false
        
        var nameLabel: String = ""
        var calorieLabel: String = "0"
        var proteinLabel: String = "0"
        var carbsLabel: String = "0"
        var fatLabel: String = "0"
        
        var isSendButtonDisabled: Bool {
            if !hasResult {
                description.isEmpty
            } else {
                !resultValid
            }
        }
        
        var imageName: String {
            return hasResult ? "checkmark" : "paperplane.fill"
        }
        
        private var resultValid: Bool {
            let nameOK = !nameLabel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let caloriesOK = Double(calorieLabel) ?? -1 >= 0
            let proteinOK  = Double(proteinLabel)  ?? -1 >= 0
            let carbsOK    = Double(carbsLabel)    ?? -1 >= 0
            let fatOK      = Double(fatLabel)      ?? -1 >= 0
            return nameOK && caloriesOK && proteinOK && carbsOK && fatOK
        }
        
        private let onSave: (_: Food) -> Void
        
        init(onSave: @escaping (_: Food) -> Void, llmService: LLMServiceProviding, dataService: DataServiceProviding) {
            self.llmService = llmService
            self.dataService = dataService
            self.onSave = onSave
        }
        
        func sendButtonPressed() {
            // TODO: Investigate @MainActor usage
            if hasResult {
                saveResult()
            } else {
                Task { try await sendDescriptionToLLM() }
            }
        }
        
        // Helpers
        private func sendDescriptionToLLM() async throws {
            do {
                isLoading = true
                let foodDTO = try await llmService.estimateNutrition(for: description)
                isLoading = false
                hasResult = true
                
                // Update UI
                calorieLabel = String(Int(foodDTO.calories))
                proteinLabel = String(Int(foodDTO.protein))
                carbsLabel = String(Int(foodDTO.carbs))
                fatLabel = String(Int(foodDTO.fat))
                nameLabel = foodDTO.name
            } catch {
                print(error.localizedDescription)
            }
        }
        
        private func saveResult() {
            let food = Food(
                name: nameLabel,
                calories: Double(calorieLabel)!,
                protein: Double(proteinLabel)!,
                carbs: Double(carbsLabel)!,
                fat: Double(fatLabel)!,
                timestamp: .now
            )
            onSave(food)
        }
    }
}
