//
//  ViewModel.swift
//  MacroMate
//
//  Created by Petar Iliev on 15.10.25.
//

import SwiftUI

extension FoodView {
    @Observable
    class ViewModel {
        private(set) var foods: [Food] = []
        var showLogView: Bool = false
        var showIntelligenceLogView: Bool = false
        
        let dataService: DataServiceProviding
        let llmService: LLMServiceProviding
        
        var onSave: (Food) -> Void {
            { [weak self] food in self?.saveFood(food: food) }
        }
        
        init(
            dataService: DataServiceProviding,
            llmService: LLMServiceProviding,
            foods: [Food] = []
        ) {
            self.dataService = dataService
            self.llmService = llmService
            self.foods = foods
        }
        
        func onDelete(indexSet: IndexSet) {
            let index = indexSet.first!
            let food = foods[index]
            dataService.delete(food)
            foods.remove(at: index)
        }
        
        func manualLogButtonPressed() {
            showLogView = true
        }
        
        func describeMealButtonPressed() {
            showIntelligenceLogView = true
        }
        
        func onAppear() {
            do { foods = try dataService.fetchFoods() }
            catch { print("Error: \(error)") }
        }
        
        private func saveFood(food: Food) {
            foods.insert(food, at: 0)
            
            do {
                try dataService.save(food)
            } catch {
                print("Error: \(error)")
            }
            
            showLogView = false
            showIntelligenceLogView = false
        }
    }
}
